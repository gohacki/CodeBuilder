//
//  SettingsView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var searchText = ""
    @State private var showingSignIn = false

    var body: some View {
        NavigationStack {
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
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel.shared)
}
