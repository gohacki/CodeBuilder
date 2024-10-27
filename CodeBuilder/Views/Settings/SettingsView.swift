//
//  SettingsView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/26/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var showingSignIn = false

    // Menu items for settings
    let settingsItems: [MenuItem] = [
        MenuItem(
            title: "General",
            subtitle: "Customize app settings",
            iconName: "gearshape.fill",
            color: .blue,
            destination: AnyView(Text("General Settings"))
        ),
        MenuItem(
            title: "Notifications",
            subtitle: "Manage notification preferences",
            iconName: "bell.fill",
            color: .red,
            destination: AnyView(Text("Notification Settings"))
        ),
        MenuItem(
            title: "Widgets",
            subtitle: "Configure your widgets",
            iconName: "square.grid.2x2.fill",
            color: .orange,
            destination: AnyView(Text("Widget Settings"))
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Profile Card
                if authViewModel.isSignedIn {
                    ProfileCardView()
                } else {
                    SignInPromptView(showingSignIn: $showingSignIn)
                }

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
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingSignIn) {
                SignInView()
                    .environmentObject(authViewModel)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(UIColor.systemBackground),
                        Color(UIColor.secondarySystemBackground)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
}

struct ProfileCardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationLink(destination: AccountView()) {
            HStack(spacing: 16) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.blue)

                // User Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(authViewModel.user?.displayName ?? "No Name")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    Text("Account, CodeBuilder+, and more")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.cardBackground)
                    .shadow(
                        color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.1),
                        radius: 8, x: 0, y: 4
                    )
            )
            .padding(.horizontal)
        }
    }
}

struct SignInPromptView: View {
    @Binding var showingSignIn: Bool
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: {
            showingSignIn = true
        }) {
            HStack(spacing: 16) {
                // Sign-In Icon
                Image(systemName: "person.badge.plus.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)

                // Sign-In Info
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sign In")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    Text("Access your account and more")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(
                        color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.1),
                        radius: 8, x: 0, y: 4
                    )
            )
            .padding(.horizontal)
        }
    }
}

struct SettingsOptionView: View {
    var title: String
    var subtitle: String
    var iconName: String
    var iconColor: Color
    var destination: AnyView
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                // Icon
                Image(systemName: iconName)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(iconColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                // Text
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.cardBackground)
                    .shadow(
                        color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.1),
                        radius: 8, x: 0, y: 4
                    )
            )
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}
