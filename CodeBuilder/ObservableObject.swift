//
//  ObservableObject.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/1/24.
//
import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn: Bool = false
    @Published var authErrorMessage: String?

    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        addListeners()
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
            DispatchQueue.main.async {
                self.user = nil
                self.isSignedIn = false
            }
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
}
