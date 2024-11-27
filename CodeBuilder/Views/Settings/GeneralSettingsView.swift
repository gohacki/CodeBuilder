//
//  GeneralSettingsView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 11/26/24.
//
import SwiftUI

struct GeneralSettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel

    var body: some View {
        List {
            // Account Section
          Section {
            NavigationLink(destination: PreferencesView()) {
              HStack {
                Image(systemName: "info.square.fill")
                  .foregroundColor(.gray)
                Text("About")
              }
            }
            
            NavigationLink(destination: PreferencesView()) {
              HStack {
                Image(systemName: "globe")
                  .foregroundColor(.blue)
                Text("Language")
              }
            }
            
            NavigationLink(destination: PreferencesView()) {
              HStack {
                Image(systemName: "bell.badge.fill")
                  .foregroundColor(.red)
                Text("Notifications")
              }
            }
            
            NavigationLink(destination: PreferencesView()) {
              HStack {
                Image(systemName: "speaker.wave.3.fill")
                  .foregroundColor(.pink)
                Text("Sounds & Haptics")
              }
            }
            
            NavigationLink(destination: PreferencesView()) {
              HStack {
                Image(systemName: "widget.small")
                  .foregroundColor(.orange)
                Text("Widgets")
              }
            }
          }

            // Add more sections as needed
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("General Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Placeholder for PreferencesView
struct PreferencesView: View {
    var body: some View {
        Text("Settings")
            .font(.largeTitle)
            .foregroundColor(.primary)
            .navigationTitle("Preferences")
    }
}

#Preview {
  GeneralSettingsView()
      .environmentObject(AuthViewModel.shared)
      .environmentObject(UserStatsViewModel())
  }
