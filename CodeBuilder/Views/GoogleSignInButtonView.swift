//
//  GoogleSignInButtonView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/1/24.
//


import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInButtonView: View {
    var body: some View {
        GoogleSignInButton(action: handleSignInButton)
            .cornerRadius(10)
            .padding(.horizontal)
    }

    func handleSignInButton() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                print("Error during Google Sign-In: \(error.localizedDescription)")
                return
            }

            if let user = signInResult?.user {
                // Update your AuthViewModel accordingly
                DispatchQueue.main.async {
                    AuthViewModel.shared.updateSignInState(user: user)
                }
            }
        }
    }
}

#Preview {
  GoogleSignInButtonView()
}
