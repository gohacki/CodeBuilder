//
//  MainTabView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/27/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // home screen tab
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // problems list tab
            ProblemsView()
                .tabItem {
                    Label("Problems", systemImage: "list.number")
                }
            
            // daily challenge tab
            DailyChallengeView()
                .tabItem {
                    Label("Daily Challenge", systemImage: "star.fill")
                }
            
            // forum screen tab
            ForumView()
                .tabItem {
                    Label("Forum", systemImage: "paperplane.fill")
                }
            
            // settings screen tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel.shared) // shared auth state
            .environmentObject(UserStatsViewModel()) // user stats data
            .environmentObject(ProblemsData.shared) // problems data
            .environmentObject(ForumViewModel()) // forum data
    }
}
