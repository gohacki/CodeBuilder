// ContentView.swift
import SwiftUI

struct ContentView: View {
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
            ForumView()
            .tabItem {
                Text("Forum")
            }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
        .environmentObject(ProblemsData.shared)
}
