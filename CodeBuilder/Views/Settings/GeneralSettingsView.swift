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
            Section(header: Text("Account")) {
                NavigationLink(destination: AccountView()) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                        Text("Account")
                    }
                }
            }

            // Additional General Settings Sections
            Section(header: Text("Preferences")) {
                NavigationLink(destination: PreferencesView()) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.gray)
                        Text("Preferences")
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
        Text("Preferences Settings")
            .font(.largeTitle)
            .foregroundColor(.primary)
            .navigationTitle("Preferences")
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
            .environmentObject(AuthViewModel.shared)
            .environmentObject(UserStatsViewModel())
    }
}
