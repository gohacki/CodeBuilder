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

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn: Bool = false
    @Published var authErrorMessage: String?
  static let shared = AuthViewModel()

    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        addListeners()
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

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: accessToken)

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
            }
        }
    }
}
