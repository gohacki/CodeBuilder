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
    @Environment(\.colorScheme) var colorScheme
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
                    .padding(.bottom, 20)
                
                // Custom input fields
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
                
                Button("Sign In") {
                    authViewModel.signIn(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
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
                .padding(.vertical, 10)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                // Social Sign-In Buttons
                VStack(spacing: 10) {
                    SignInWithAppleButton(
                        onRequest: { request in
                            // Handle request
                        },
                        onCompletion: { result in
                            // Handle completion
                        }
                    )
                    .signInWithAppleButtonStyle(
                      // TODO: this isnt working ? always stays black
                      colorScheme == .dark ? .white : .black
                    )
                    .frame(height: 52)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 15)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                // Improved Sign Up Prompt
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)
                  NavigationLink(destination: SignUpView().environmentObject(authViewModel)) {
                    Text("Sign Up")
                      .bold()
                  }
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
