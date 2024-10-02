//
//  SignIn.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/1/24.
//

import SwiftUI
import AuthenticationServices // For SignInWithAppleButton

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var showingSignUp = false
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("CodeBuilder")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 40)
                
                // Use a Form for input fields
                Form {
                    Section {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        SecureField("Password", text: $password)
                    }
                }
                .frame(height: 150)
                .padding(.horizontal)
                
                Button("Sign In") {
                    authViewModel.signIn(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                
                // Improved Separator
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.5))
                    Text("OR")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.5))
                }
                .padding(.vertical, 20)
                .padding(.horizontal)
                .padding(.bottom, 50)
                
                Button(action: {
                    authViewModel.signInWithGoogle()
                }) {
                    HStack {
                        Image("google_logo") // Ensure you have a Google logo asset
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Sign in with Google (we need an asset)")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .padding(.horizontal)
                .padding(.bottom, 8)
              
                
                // Sign in with Apple Button
                SignInWithAppleButton(
                    onRequest: { request in
                        // Handle request
                    },
                    onCompletion: { result in
                        // Handle completion
                    }
                )
                .signInWithAppleButtonStyle(.white)
                .frame(height: 45)
                .padding(.horizontal)
                
                Spacer()
                
                Button("Don't have an account? Sign Up") {
                    showingSignUp = true
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $showingSignUp) {
                    SignUpView()
                        .environmentObject(authViewModel)
                }
            }
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(authViewModel.authErrorMessage ?? "An error occurred"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onReceive(authViewModel.$authErrorMessage) { errorMessage in
                if errorMessage != nil {
                    showingAlert = true
                }
            }
            .onReceive(authViewModel.$isSignedIn) { isSignedIn in
                if isSignedIn {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}
