//
//  AccountView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userStatsViewModel: UserStatsViewModel // Add this line

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.blue)
                    .padding(.top, 25)

                VStack(spacing: 2) {
                    Text(authViewModel.user?.displayName ?? "No Name")
                        .font(.system(size: 28, weight: .semibold))
                    Text(verbatim: authViewModel.user?.email ?? "No Email")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                  /*
                    // Display Problems Solved
                    Text("Problems Solved: \(userStatsViewModel.problemsSolved)")
                        .font(.system(size: 18))
                        .foregroundColor(.blue)
                        .padding(.top, 5)*/
                }

                List {
                    Section {
                        NavigationLink(destination: Text("Personal Information")) {
                            HStack {
                                Image(systemName: "person.text.rectangle.fill")
                                    .foregroundColor(.blue)
                                Text("Personal Information")
                            }
                        }

                        NavigationLink(destination: Text("Subscription Info")) {
                            HStack {
                                Image(systemName: "plus.arrow.trianglehead.clockwise")
                                    .foregroundColor(.blue)
                                Text("Subscriptions")
                            }
                        }
                    }

                    Section {
                        Button(action: {
                            authViewModel.signOut()
                        }) {
                            Text("Sign Out")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.red)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("CodeBuilder Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthViewModel.shared) // Use the shared singleton instance
        .environmentObject(UserStatsViewModel()) // Provide UserStatsViewModel
}
