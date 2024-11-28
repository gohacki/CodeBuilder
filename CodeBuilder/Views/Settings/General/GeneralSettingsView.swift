//
//  GeneralSettingsView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 11/26/24.
//
import SwiftUI

struct GeneralSettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel // access authentication details
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel // access user stats

    var body: some View {
        List {
            // account-related settings section
            Section {
                // link to "About" settings
                NavigationLink(destination: PreferencesView()) {
                    HStack {
                        Image(systemName: "info.square.fill")
                            .foregroundColor(.gray)
                        Text("About")
                    }
                }
                
                // link to "Language" settings
                NavigationLink(destination: PreferencesView()) {
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.blue)
                        Text("Language")
                    }
                }
                
                // link to "Notifications" settings
                NavigationLink(destination: PreferencesView()) {
                    HStack {
                        Image(systemName: "bell.badge.fill")
                            .foregroundColor(.red)
                        Text("Notifications")
                    }
                }
                
                // link to "Sounds & Haptics" settings
                NavigationLink(destination: PreferencesView()) {
                    HStack {
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.pink)
                        Text("Sounds & Haptics")
                    }
                }
                
                // link to "Widgets" settings
                NavigationLink(destination: PreferencesView()) {
                    HStack {
                        Image(systemName: "widget.small")
                            .foregroundColor(.orange)
                        Text("Widgets")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle()) // group style for the list
        .navigationTitle("General Settings") // title for the screen
        .navigationBarTitleDisplayMode(.inline) // display title in a compact style
    }
}

#Preview {
    GeneralSettingsView()
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
}
