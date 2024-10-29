// ContentView.swift
import SwiftUI

struct ContentView: View {
<<<<<<< HEAD
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ProblemsView()
                .tabItem {
                    Label("Problems", systemImage: "list.number")
                }
            DailyChallengeView()
                .tabItem {
                    Label("Daily Challenge", systemImage: "star.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
=======
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel

    var body: some View {
        if !authViewModel.isSignedIn {
            SignInView()
        } else {
            TabView {
                // Home
                NavigationStack {
                    HomeView()
                        .navigationDestination(for: TabDestination.self) { destination in
                            switch destination {
                            case .problems:
                                ProblemsView()
                            case .learning:
                                LearningView()
                            case .resumeTips:
                                ResumeView()
                            }
                        }
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                // Search
                NavigationStack {
                    SearchView()
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                
                // Daily Challenge
                NavigationStack {
                    DailyChallengeView()
                }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Daily Challenge")
                }
                
                // Settings
                NavigationStack {
                    SettingsView()
                }
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
            .accentColor(.blue)
>>>>>>> f31f8e595d8f7cc3dbe376bb2259ae8944a02eef
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
<<<<<<< HEAD
        .environmentObject(ProblemsData.shared)
=======
>>>>>>> f31f8e595d8f7cc3dbe376bb2259ae8944a02eef
}
