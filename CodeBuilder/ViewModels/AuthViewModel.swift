import Foundation
import FirebaseAuth
import Combine
import Firebase
import FirebaseFirestore

// MARK: - Firestore Field Keys
// Keys for fields in the Firestore user document
struct FirestoreKeys {
    static let email = "email"
    static let problemsSolved = "problemsSolved"
    static let streak = "streak"
    static let lastProblemSolvedDate = "lastProblemSolvedDate"
    static let solvedProblemIDs = "solvedProblemIDs"
    static let displayName = "displayName"
}

// MARK: - AuthViewModel
class AuthViewModel: ObservableObject {
    @Published var user: User? // Current authenticated user
    @Published var isSignedIn: Bool = false // Tracks authentication state
    @Published var authErrorMessage: String? // Holds any authentication errors for UI

    // Singleton instance for global access
    static let shared = AuthViewModel()

    private var authStateListenerHandle: AuthStateDidChangeListenerHandle? // Firebase auth listener

    // Private initializer to enforce singleton usage
    private init() {
        addListeners() // Attach Firebase auth state listener
    }

    deinit {
        removeListeners() // Detach Firebase auth state listener
    }

    // MARK: - Listener Management

    // Adds an auth state listener to track user login/logout changes
    private func addListeners() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                self?.user = user
                self?.isSignedIn = user != nil
            }
        }
    }

    // Removes the auth state listener
    private func removeListeners() {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // MARK: - Authentication Methods

    /// Signs in the user with email and password.
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.authErrorMessage = error.localizedDescription // Capture error message
                    completion(false, error)
                } else if let user = result?.user {
                    self?.user = user // Update the current user
                    self?.isSignedIn = true // Mark user as signed in
                    completion(true, nil)
                } else {
                    self?.authErrorMessage = "Unknown sign-in error."
                    completion(false, nil)
                }
            }
        }
    }

    /// Signs out the current user.
    func signOut() {
        do {
            try Auth.auth().signOut() // Attempt to sign out
            DispatchQueue.main.async {
                self.user = nil // Clear the current user
                self.isSignedIn = false // Mark user as signed out
                self.authErrorMessage = nil // Clear any auth error messages
                print("User signed out")
            }
        } catch let error {
            print("Sign out error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.authErrorMessage = error.localizedDescription // Capture error message
            }
        }
    }

    /// Signs up a new user with email, password, and display name.
    func signUp(email: String, password: String, displayName: String, completion: @escaping (Bool, Error?) -> Void) {
        // Input Validation
        guard isValidEmail(email) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Invalid email format."
                completion(false, nil)
            }
            return
        }

        guard isValidPassword(password) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Password must be at least 6 characters."
                completion(false, nil)
            }
            return
        }

        guard isValidDisplayName(displayName) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Display name cannot be empty."
                completion(false, nil)
            }
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Sign up error: \(error.localizedDescription)")
                    self?.authErrorMessage = error.localizedDescription // Capture error message
                    completion(false, error)
                } else if let user = result?.user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName // Update user profile display name
                    changeRequest.commitChanges { [weak self] error in
                        if let error = error {
                            print("Profile update error: \(error.localizedDescription)")
                            self?.authErrorMessage = error.localizedDescription // Capture error message
                            completion(false, error)
                        } else {
                            self?.user = Auth.auth().currentUser // Update the current user
                            self?.isSignedIn = true // Mark user as signed in
                            print("User signed up and profile updated")
                            self?.createUserProfileInFirestore() // Create Firestore profile
                            completion(true, nil)
                        }
                    }
                } else {
                    self?.authErrorMessage = "Unknown sign-up error."
                    completion(false, nil)
                }
            }
        }
    }

    // MARK: - User Profile Management

    /// Creates or updates the user profile in Firestore.
    private func createUserProfileInFirestore() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)

        userRef.setData([
            FirestoreKeys.email: Auth.auth().currentUser?.email ?? "",
            FirestoreKeys.problemsSolved: 0,
            FirestoreKeys.streak: 0,
            FirestoreKeys.lastProblemSolvedDate: Timestamp(date: Date())
        ], merge: true) { [weak self] error in
            if let error = error {
                print("Error adding/updating user in Firestore: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.authErrorMessage = "Failed to create user profile." // Capture error message
                }
            } else {
                print("User profile created/updated in Firestore!")
            }
        }
    }

    // MARK: - Validation Methods

    /// Validates email format.
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    /// Validates that the password is at least 6 characters long.
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    /// Validates that the display name is not empty.
    private func isValidDisplayName(_ displayName: String) -> Bool {
        return !displayName.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
