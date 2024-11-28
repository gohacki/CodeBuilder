// SettingsView.swift
// CodeBuilder
// Created by aaron perkel on 9/26/24.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        GradientBackgroundView {
            NavigationStack {
                SettingsContentView()
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.large)
                    .applyBackgroundGradient()
            }
        }
    }
}

#Preview {
      SettingsView()
          .environmentObject(AuthViewModel.shared)
          .environmentObject(UserStatsViewModel())
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
                    .fill(Color(UIColor.secondarySystemBackground))
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
        .environmentObject(AuthViewModel.shared)
        .environmentObject(UserStatsViewModel())
}
