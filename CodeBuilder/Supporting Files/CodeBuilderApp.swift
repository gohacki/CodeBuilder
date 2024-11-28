// CodeBuilderApp.swift
import SwiftUI
import Firebase

// sets entry point for the app
@main
struct CodeBuilderApp: App {
    // set up app delegate for firebase integration
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Set up state opbjects for view models across app
    @StateObject var authViewModel = AuthViewModel.shared // manages authentication
    @StateObject var userStatsViewModel = UserStatsViewModel() // manage user statistics (problem streaks and number of problems solved)
    @StateObject var problemsData = ProblemsData.shared // sets up shared problem data
    @StateObject var forumViewModel = ForumViewModel() // manage forum posts and replies
    
    // defining the main user interface
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(authViewModel) // inject authentication logic
                .environmentObject(userStatsViewModel) // inject user stats management model
                .environmentObject(problemsData) // inject problem data management model
                .environmentObject(forumViewModel) // inject forum data management model
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
        .environmentObject(ProblemsData.shared)
        .environmentObject(ForumViewModel())
}
