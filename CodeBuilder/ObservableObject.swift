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
}



class UserStatsViewModel: ObservableObject {
    @Published var problemsSolved: Int = 0
    @Published var streak: Int = 0
    @Published var solvedProblemIDs: [String] = []

    private var db = Firestore.firestore()
    private var userID: String? {
        return Auth.auth().currentUser?.uid
    }

    func problemSolved(problemID: UUID) {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)

        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: currentDate)

        db.runTransaction { (transaction, errorPointer) -> Any? in
            let document: DocumentSnapshot
            do {
                document = try transaction.getDocument(userRef)
            } catch let fetchError {
                print("Failed to fetch document: \(fetchError)")
                return nil
            }

            var problemsSolved = document.data()?["problemsSolved"] as? Int ?? 0
            var streak = document.data()?["streak"] as? Int ?? 0
            let lastSolvedDate = document.data()?["lastProblemSolvedDate"] as? String ?? ""

            let calendar = Calendar.current
            if let lastDate = dateFormatter.date(from: lastSolvedDate) {
                let daysDifference = calendar.dateComponents([.day], from: lastDate, to: currentDate).day ?? 0
                streak = (daysDifference == 1) ? streak + 1 : 1
            } else {
                streak = 1
            }

            problemsSolved += 1

            transaction.updateData([
                "problemsSolved": problemsSolved,
                "streak": streak,
                "lastProblemSolvedDate": currentDateString,
                "solvedProblemIDs": FieldValue.arrayUnion([problemID.uuidString])
            ], forDocument: userRef)

            return nil
        } completion: { [weak self] (result, error) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.problemsSolved += 1
//                    self?.streak = streak
                    self?.solvedProblemIDs.append(problemID.uuidString)
                }
            }
        }
    }

    func fetchUserStats() {
        guard let userID = userID else { return }
        let userRef = db.collection("users").document(userID)

        userRef.getDocument { [weak self] (document, error) in
            guard let self = self, let document = document, document.exists else {
                print("User stats not found")
                return
            }

            DispatchQueue.main.async {
                self.problemsSolved = document.data()?["problemsSolved"] as? Int ?? 0
                self.streak = document.data()?["streak"] as? Int ?? 0
                self.solvedProblemIDs = document.data()?["solvedProblemIDs"] as? [String] ?? []
            }
        }
    }
}
