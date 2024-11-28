//
//  SettingsContentView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/27/24.
//


// Views/SettingsContentView.swift

import SwiftUI

struct SettingsContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    // Computed property for settings items
    var settingsItems: [MenuItem] {
        [
            MenuItem(
                title: authViewModel.user?.displayName ?? "No Name",
                subtitle: "Account, CodeBuilder+, and more",
                iconName: "person.fill",
                color: .blue,
                destination: AnyView(AccountView())
            ),
            MenuItem(
                title: "General",
                subtitle: "Customize app settings",
                iconName: "gear",
                color: .gray,
                destination: AnyView(GeneralSettingsView())
            )
        ]
    }

    var body: some View {
        VStack(spacing: 20) {
            // Settings Options
            VStack(spacing: 16) {
                ForEach(settingsItems, id: \.title) { item in
                    SettingsOptionView(
                        title: item.title,
                        subtitle: item.subtitle ?? "",
                        iconName: item.iconName,
                        iconColor: item.color,
                        destination: item.destination
                    )
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

            Spacer()
        }
    }
}