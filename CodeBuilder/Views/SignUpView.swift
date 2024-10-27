//
//  SignUpView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 10/1/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    @State private var showingAlert = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                
                // Custom input fields
                VStack(spacing: 16) {
                    TextField("Display Name", text: $displayName)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
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
                
                Button("Sign Up") {
                    authViewModel.signUp(email: email, password: password, displayName: displayName)
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                Spacer()
            }
            .navigationTitle("Sign Up")
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
    SignUpView()
        .environmentObject(AuthViewModel.shared) // Use the shared singleton instance
        .environmentObject(UserStatsViewModel()) // Provide UserStatsViewModel if needed
}
