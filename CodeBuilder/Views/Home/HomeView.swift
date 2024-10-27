//
//  HomeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var showingSignIn = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Header
                    if authViewModel.isSignedIn {
                        ProfileHeaderView()
                    } else {
                        SignInPromptView(showingSignIn: $showingSignIn)
                    }
                    
                    // AutoScroller Carousel
                    AutoScroller(path: $path)
                    
                    // Additional Content
                    VStack(spacing: 16) {
                        Text("Your Progress")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            ProgressCardView(
                                title: "Problems Solved",
                                value: "42",
                                iconName: "checkmark.seal.fill",
                                iconColor: .green
                            )
                            ProgressCardView(
                                title: "Lessons Completed",
                                value: "15",
                                iconName: "book.fill",
                                iconColor: .orange
                            )
                            ProgressCardView(
                                title: "Resume Tips Read",
                                value: "5",
                                iconName: "briefcase.fill",
                                iconColor: .purple
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                .sheet(isPresented: $showingSignIn) {
                    SignInView()
                        .environmentObject(authViewModel)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
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
    }
}

// Profile Header View
struct ProfileHeaderView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.blue)

            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome, \(authViewModel.user?.displayName ?? "No Name")!")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
                Text("Ready to continue learning?")
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

// Progress Card View
struct ProgressCardView: View {
    var title: String
    var value: String
    var iconName: String
    var iconColor: Color
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .foregroundColor(.white)
                .padding()
                .background(iconColor)
                .clipShape(Circle())

            Text(value)
                .font(.title2.bold())
                .foregroundColor(.primary)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
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

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
