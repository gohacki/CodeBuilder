// Views/Authentication/SignUpView.swift

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
              
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(40)
              
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
                        .background(Color(.quaternarySystemFill))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.quaternarySystemFill))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.quaternarySystemFill))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)
            
                Button("Sign Up") {
                    authViewModel.signUp(email: email, password: password, displayName: displayName) { success, error in
                        if success {
                            // Optionally handle additional success logic here
                            // For example, reset the input fields
                            email = ""
                            password = ""
                            displayName = ""
                            // The view will dismiss automatically via the onReceive for isSignedIn
                        } else {
                            // Handle error by showing an alert
                            alertMessage = error?.localizedDescription ?? "An unknown error occurred."
                            showingAlert = true
                        }
                    }
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
                    message: Text(alertMessage),
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel.shared)
            .environmentObject(UserStatsViewModel())
    }
}
