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

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn: Bool = false
    @Published var authErrorMessage: String?
    static let shared = AuthViewModel()
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        addListeners()
    }
    
    func createUserProfileInFirestore() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        // Reference to the user's Firestore document
        let userRef = db.collection("users").document(userID)
        
        // Set user data
        userRef.setData([
            "email": Auth.auth().currentUser?.email ?? "",
            "problemsSolved": 0,
            "streak": 0,
            "lastProblemSolvedDate": ""
        ]) { error in
            if let error = error {
                print("Error adding user to Firestore: \(error.localizedDescription)")
            } else {
                print("User profile created in Firestore!")
            }
        }
    }
    
    func updateSignInState(user: GIDGoogleUser?) {
        self.isSignedIn = user != nil
    }
    
    func addListeners() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                self?.user = user
                self?.isSignedIn = user != nil
            }
        }
    }
    
    func removeListeners() {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Sign in error: \(error.localizedDescription)")
                    self?.authErrorMessage = error.localizedDescription
                } else {
                    print("User signed in: \(result?.user.uid ?? "")")
                    self?.user = result?.user
                    self?.isSignedIn = true
                    self?.createUserProfileInFirestore()
                }
            }
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            self.user = nil
            self.isSignedIn = false
            print("User signed out")
        } catch let error {
            print("Sign out error: \(error.localizedDescription)")
            authErrorMessage = error.localizedDescription
        }
    }
    func signUp(email: String, password: String, displayName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Sign up error: \(error.localizedDescription)")
                    self?.authErrorMessage = error.localizedDescription
                } else if let user = result?.user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
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
                }
            }
        }
    }
    func signInWithGoogle() {
        // Get the root view controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("No root view controller")
            return
        }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign-in flow.
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] signInResult, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                self?.authErrorMessage = error.localizedDescription
                return
            }
            
            guard let signInResult = signInResult else {
                print("Sign-in result is nil")
                return
            }
            
            guard let idToken = signInResult.user.idToken?.tokenString else {
                print("No ID token")
                return
            }
            
            let accessToken = signInResult.user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            // Sign in to Firebase with Google credentials
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if let error = error {
                    print("Firebase sign in with Google error: \(error.localizedDescription)")
                    self?.authErrorMessage = error.localizedDescription
                    return
                }
                
                // User is signed in
                self?.user = authResult?.user
                self?.isSignedIn = true
                print("User signed in with Google: \(self?.user?.uid ?? "")")
                
                // Optionally, create or update the user's profile in Firestore
                self?.createUserProfileInFirestore()
            }
        }
    }
}

class UserStatsViewModel: ObservableObject {
    @Published var problemsSolved: Int = 0
    @Published var streak: Int = 0

    private var db = Firestore.firestore()
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }

    // Fetch user stats from Firestore
    func fetchUserStats() {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self?.problemsSolved = data?["problemsSolved"] as? Int ?? 0
                self?.streak = data?["streak"] as? Int ?? 0
            } else {
                print("User stats not found")
            }
        }
    }

    // Update user stats when a problem is solved
    func problemSolved() {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)
        
        // Fetch the current date
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: currentDate)

        userRef.getDocument { [weak self] (document, error) in
            if let document = document, document.exists {
                var problemsSolved = document.data()?["problemsSolved"] as? Int ?? 0
                var streak = document.data()?["streak"] as? Int ?? 0
                let lastSolvedDate = document.data()?["lastProblemSolvedDate"] as? String ?? ""

                // Check if the problem was solved consecutively
                let calendar = Calendar.current
                if let lastDate = dateFormatter.date(from: lastSolvedDate) {
                    let daysDifference = calendar.dateComponents([.day], from: lastDate, to: currentDate).day ?? 0
                    if daysDifference == 1 {
                        streak += 1 // Increment the streak if it's consecutive
                    } else if daysDifference > 1 {
                        streak = 1 // Reset the streak if more than 1 day passed
                    }
                } else {
                    streak = 1 // If no previous date, start the streak
                }

                problemsSolved += 1

                // Update Firebase
                userRef.updateData([
                    "problemsSolved": problemsSolved,
                    "streak": streak,
                    "lastProblemSolvedDate": currentDateString
                ])

                // Update local variables
                self?.problemsSolved = problemsSolved
                self?.streak = streak
            }
        }
    }
}
