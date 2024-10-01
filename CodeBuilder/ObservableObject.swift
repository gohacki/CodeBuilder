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
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        addListeners()
    }
    
    func addListeners() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.user = user
            self?.isSignedIn = user != nil
        }
    }
    
    func removeListeners() {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Sign in error: \(error.localizedDescription)")
                // Handle error (e.g., show alert)
            } else {
                print("User signed in: \(result?.user.uid ?? "")")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isSignedIn = false
            print("User signed out")
        } catch let error {
            print("Sign out error: \(error.localizedDescription)")
            // Handle error (e.g., show alert)
        }
    }
}
