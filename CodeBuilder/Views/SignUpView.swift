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
        VStack(spacing: 16) {
            Text("Sign Up")
                .font(.largeTitle)
                .padding(.top, 40)
            
            TextField("Display Name", text: $displayName)
                .autocapitalization(.words)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button(action: {
                authViewModel.signUp(email: email, password: password, displayName: displayName)
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .onReceive(authViewModel.$isSignedIn) { isSignedIn in
                if isSignedIn {
                    dismiss()
                }
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

#Preview {
  SignUpView()
    .environmentObject(AuthViewModel())
}
