// Views/ContentView.swift
import SwiftUI

struct ContentView: View {
    // call the shared authentication view model
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        // set up conditional view rendering
        Group {
            if authViewModel.isSignedIn {
                // if user is signed in, show main tab view
                MainTabView()
            } else {
                // otherwise prompt them to sign in
                SignInView()
            }
        }
        .animation(.easeInOut, value: authViewModel.isSignedIn)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel.shared)
            .environmentObject(UserStatsViewModel())
            .environmentObject(ProblemsData.shared)
            .environmentObject(ForumViewModel())
    }
}
