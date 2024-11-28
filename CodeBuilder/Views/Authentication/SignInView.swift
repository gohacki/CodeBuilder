// Views/Authentication/SignInView.swift

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
    @State private var alertMessage = ""
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(40)
                
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
                
                Button("Sign In") {
                    authViewModel.signIn(email: email, password: password) { success, error in
                        if success {
                            // Optionally handle additional success logic here
                            // For example, reset the input fields
                            email = ""
                            password = ""
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
                
                // Improved Sign Up Prompt with Button
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)
                    Button(action: {
                        showingSignUp = true
                    }) {
                        Text("Sign Up")
                            .bold()
                    }
                }
                .padding(.bottom, 20)
                
                // Optionally, you can remove the .sheet from inside the HStack and place it outside
            }
            .navigationTitle("Sign In")
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
            .sheet(isPresented: $showingSignUp) {
                SignUpView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AuthViewModel.shared)
            .environmentObject(UserStatsViewModel())
    }
}
