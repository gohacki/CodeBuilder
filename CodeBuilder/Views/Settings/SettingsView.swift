//
//  SettingsView.swift
//  CodeBuilder
//
<<<<<<< HEAD
//  Created by aaron perkel on 9/26/24.
=======
//  Created by Miro Gohacki on 9/24/24.
>>>>>>> f31f8e595d8f7cc3dbe376bb2259ae8944a02eef
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
<<<<<<< HEAD
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
=======
            SearchBar(text: $searchText)
            List {
                Section {
                    if authViewModel.isSignedIn {
                        // Show account information
                        NavigationLink(destination: AccountView()) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .foregroundStyle(.blue)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(authViewModel.user?.displayName ?? "No Name")
                                        .font(.system(size: 20, weight: .semibold))
                                    Text("Account, CodeBuilder+, and more")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    } else {
                        // Show sign-in prompt
                        Button(action: {
                            showingSignIn = true
                        }) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                    .resizable()
                                    .frame(width: 55, height: 50)
                                    .foregroundStyle(.blue)
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Sign In")
                                        .font(.system(size: 20, weight: .semibold))
                                    Text("Access your account and more")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .sheet(isPresented: $showingSignIn) {
                            SignInView()
                                .environmentObject(authViewModel)
                                .environmentObject(UserStatsViewModel()) // Provide UserStatsViewModel if needed
                        }
                    }
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
                
                // Other settings sections...
                Section {
                    NavigationLink(destination: Text("General Settings")) {
                        HStack {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray2))
                                        .frame(width: 28, height: 28)
                                )
                                .padding(.trailing, 4)
                            Text("General")
                        }
                    }
                    
                    NavigationLink(destination: Text("Notification Settings")) {
                        HStack {
                            Image(systemName: "bell.badge.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.red))
                                        .frame(width: 28, height: 28)
                                )
                                .padding(.trailing, 4)
                            Text("Notifications")
                        }
                    }
                    
                    NavigationLink(destination: Text("Widget Settings")) {
                        HStack {
                            Image(systemName: "widget.small")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.orange))
                                        .frame(width: 28, height: 28)
                                )
                                .padding(.trailing, 4)
                            Text("Widgets")
                        }
>>>>>>> f31f8e595d8f7cc3dbe376bb2259ae8944a02eef
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
        .environmentObject(AuthViewModel.shared) // Use the shared singleton instance
        .environmentObject(UserStatsViewModel()) // Provide UserStatsViewModel
}
