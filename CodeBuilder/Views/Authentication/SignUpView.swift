// Views/Authentication/SignUpView.swift

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel // authentication logic
    @Environment(\.dismiss) var dismiss // dismisses the view
    @State private var email = "" // user input: email
    @State private var password = "" // user input: password
    @State private var displayName = "" // user input: display name
    @State private var showingAlert = false // tracks if alert is shown
    @State private var alertMessage = "" // message to display in the alert

  var body: some View {
    GradientBackgroundView{
      NavigationStack {
        VStack {
          Spacer()
          
          // app logo
          Image("Logo")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .cornerRadius(40)
          
          Text("Create Account")
            .font(.largeTitle)
            .bold()
            .padding(.bottom, 20)
          
          // input fields
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
          
          // sign-up button
          Button("Sign Up") {
            authViewModel.signUp(email: email, password: password, displayName: displayName) { success, error in
              if success {
                email = ""
                password = ""
                displayName = ""
              } else {
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
        
        // alert for error messages
        .alert(isPresented: $showingAlert) {
          Alert(
            title: Text("Error"),
            message: Text(alertMessage),
            dismissButton: .default(Text("OK"))
          )
        }
        
        // listens for errors from the authViewModel
        .onReceive(authViewModel.$authErrorMessage) { errorMessage in
          if errorMessage != nil {
            showingAlert = true
          }
        }
        
        // automatically dismisses the view when the user is signed in
        .onReceive(authViewModel.$isSignedIn) { isSignedIn in
          if isSignedIn {
            dismiss()
          }
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
