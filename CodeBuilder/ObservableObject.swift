//
//  ObservableObject.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/1/24.
//

import Foundation
import FirebaseAuth
import Combine
import GoogleSignIn
import Firebase
import FirebaseFirestore

// MARK: - Firestore Field Keys

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
    // Published properties for UI binding
    @Published var user: User?
    @Published var isSignedIn: Bool = false
    @Published var authErrorMessage: String?
    
    // Singleton instance
    static let shared = AuthViewModel()
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    // Private initializer to enforce singleton usage
    private init() {
        addListeners()
    }
    
    deinit {
        removeListeners()
    }
    
    // MARK: - Listener Management
    
    private func addListeners() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                self?.user = user
                self?.isSignedIn = user != nil
            }
        }
    }
    
    private func removeListeners() {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    // MARK: - User Profile Management
    
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
                    self?.authErrorMessage = "Failed to create user profile."
                }
            } else {
                print("User profile created/updated in Firestore!")
            }
        }
    }
    
    // MARK: - Authentication Methods
    
    /// Validates email format using a regular expression.
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /// Validates password strength.
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    /// Validates display name.
    private func isValidDisplayName(_ displayName: String) -> Bool {
        return !displayName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    /// Signs in the user with email and password.
    func signIn(email: String, password: String) {
        // Input Validation
        guard isValidEmail(email) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Invalid email format."
            }
            return
        }
        
        guard isValidPassword(password) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Password must be at least 6 characters."
            }
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            // Ensure UI updates are on the main thread
            DispatchQueue.main.async {
                if let error = error {
                    print("Sign in error: \(error.localizedDescription)")
                    self?.authErrorMessage = error.localizedDescription
                } else if let user = result?.user {
                    print("User signed in: \(user.uid)")
                    self?.user = user
                    self?.isSignedIn = true
                    self?.createUserProfileInFirestore()
                } else {
                    self?.authErrorMessage = "Unknown sign in error."
                }
            }
        }
    }
    
    /// Signs out the current user.
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user = nil
                self.isSignedIn = false
                self.authErrorMessage = nil
                print("User signed out")
            }
        } catch let error {
            print("Sign out error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.authErrorMessage = error.localizedDescription
            }
        }
    }
    
    /// Signs up a new user with email, password, and display name.
    func signUp(email: String, password: String, displayName: String) {
        // Input Validation
        guard isValidEmail(email) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Invalid email format."
            }
            return
        }
        
        guard isValidPassword(password) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Password must be at least 6 characters."
            }
            return
        }
        
        guard isValidDisplayName(displayName) else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Display name cannot be empty."
            }
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            // Ensure UI updates are on the main thread
            DispatchQueue.main.async {
                if let error = error {
                    print("Sign up error: \(error.localizedDescription)")
                    self?.authErrorMessage = error.localizedDescription
                } else if let user = result?.user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { [weak self] error in
                        if let error = error {
                            print("Profile update error: \(error.localizedDescription)")
                            self?.authErrorMessage = error.localizedDescription
                        } else {
                            self?.user = Auth.auth().currentUser
                            self?.isSignedIn = true
                            print("User signed up and profile updated")
                            self?.createUserProfileInFirestore()
                        }
                    }
                } else {
                    self?.authErrorMessage = "Unknown sign up error."
                }
            }
        }
    }
}

// MARK: - UserStatsViewModel

class UserStatsViewModel: ObservableObject {
    // Published properties for UI binding
    @Published var problemsSolved: Int = 0
    @Published var streak: Int = 0
    @Published var solvedProblemIDs: [String] = []
    
    private var db = Firestore.firestore()
    
    // Computed property to get current user ID
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    // MARK: - Problem Solved Handling
    
    /// Records that a problem has been solved by the user.
    func problemSolved(problemID: UUID) {
        guard let userID = userID else {
            DispatchQueue.main.async {
                // Optionally, set an error message
            }
            return
        }
        
        let userRef = db.collection("users").document(userID)
        let currentDate = Date()
        
        db.runTransaction { (transaction, errorPointer) -> Any? in
            do {
                let document = try transaction.getDocument(userRef)
                
                if let data = document.data() {
                    var problemsSolved = data[FirestoreKeys.problemsSolved] as? Int ?? 0
                    var streak = data[FirestoreKeys.streak] as? Int ?? 0
                    let lastSolvedTimestamp = data[FirestoreKeys.lastProblemSolvedDate] as? Timestamp
                    let lastSolvedDate = lastSolvedTimestamp?.dateValue() ?? Date(timeIntervalSince1970: 0)
                    
                    let calendar = Calendar.current
                    let daysDifference = calendar.dateComponents([.day], from: lastSolvedDate, to: currentDate).day ?? 0
                    
                    if daysDifference == 1 {
                        streak += 1
                    } else if daysDifference > 1 {
                        streak = 1
                    }
                    
                    problemsSolved += 1
                    
                    // Use arrayUnion to prevent duplicates
                    transaction.updateData([
                        FirestoreKeys.problemsSolved: problemsSolved,
                        FirestoreKeys.streak: streak,
                        FirestoreKeys.lastProblemSolvedDate: Timestamp(date: currentDate),
                        FirestoreKeys.solvedProblemIDs: FieldValue.arrayUnion([problemID.uuidString])
                    ], forDocument: userRef)
                } else {
                    // Document does not exist, create it
                    transaction.setData([
                        FirestoreKeys.email: Auth.auth().currentUser?.email ?? "",
                        FirestoreKeys.problemsSolved: 1,
                        FirestoreKeys.streak: 1,
                        FirestoreKeys.lastProblemSolvedDate: Timestamp(date: currentDate),
                        FirestoreKeys.solvedProblemIDs: [problemID.uuidString]
                    ], forDocument: userRef)
                }
            } catch let error {
                print("Transaction failed: \(error.localizedDescription)")
                errorPointer?.pointee = error as NSError
                return nil
            }
            return nil
        } completion: { [weak self] (result, error) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
                // Optionally, set an error message
            } else {
                print("Transaction completed successfully")
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Fetch updated stats to ensure consistency
                    self.fetchUserStats()
                }
            }
        }
    }
    
    // MARK: - Fetching User Statistics
    
    /// Fetches the latest user statistics from Firestore.
    func fetchUserStats() {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user stats: \(error.localizedDescription)")
                // Optionally, set an error message
                return
            }
            
            guard let document = document, document.exists, let data = document.data() else {
                print("User stats not found")
                return
            }
            
            DispatchQueue.main.async {
                self.problemsSolved = data[FirestoreKeys.problemsSolved] as? Int ?? 0
                self.streak = data[FirestoreKeys.streak] as? Int ?? 0
                self.solvedProblemIDs = data[FirestoreKeys.solvedProblemIDs] as? [String] ?? []
            }
        }
    }
    
    // MARK: - Initialization
    
    init() {
        fetchUserStats()
    }
}
