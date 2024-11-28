//
//  ProfileCardView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/28/24.
//

import SwiftUI


// profile card at the top of the settings for user info
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
