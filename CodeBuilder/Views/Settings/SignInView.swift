//
//  SignIn.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/1/24.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var showingSignUp = false
    @State private var showingAlert = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Sign In")
                .font(.largeTitle)
                .padding(.top, 40)
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button(action: {
                authViewModel.signIn(email: email, password: password)
            }) {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .onReceive(authViewModel.$isSignedIn) { isSignedIn in
                if isSignedIn {
                    dismiss()
                }
            }
            Button(action: {
                authViewModel.signInWithGoogle()
            }) {
                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.white)
                    Text("Sign in with Google")
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
                .padding(.horizontal)
            }

            // Handle sign-in success
            .onReceive(authViewModel.$isSignedIn) { isSignedIn in
                if isSignedIn {
                    dismiss()
                }
            }
            
            Button(action: {
                showingSignUp = true
            }) {
                Text("Don't have an account? Sign Up")
                    .foregroundColor(.blue)
            }
            .padding(.top, 8)
            .sheet(isPresented: $showingSignUp) {
                SignUpView()
                    .environmentObject(authViewModel)
            }
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(authViewModel.authErrorMessage ?? "An error occurred"), dismissButton: .default(Text("OK")))
        }
        .onReceive(authViewModel.$authErrorMessage) { errorMessage in
            if errorMessage != nil {
                showingAlert = true
            }
        }
    }
}
