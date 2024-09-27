//
//  SettingsView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

struct SettingsView: View {
  @State private var searchText = ""
  var body: some View {
    NavigationStack {
      SearchBar(text: $searchText)
      List {
        
        Section {
          NavigationLink(destination: AccountView()) {
            HStack {
              Image(systemName: "person.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .foregroundStyle(.blue)
                .padding(.trailing, 8)
              
              VStack(alignment: .leading, spacing: 4) {
                Text("aaron perkel")
                  .font(.system(size: 20, weight: .semibold))
                Text("Account, CodeBuilder+, and more")
                  .font(.system(size: 14))
                  .foregroundColor(.gray)
              }
            }
            .padding(.vertical, 8)
          }
        }
        .padding(.top, 5)
        .padding(.bottom, 5)
        
        Section {
          NavigationLink(destination: GeneralSettingsView()) {
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
          
          NavigationLink(destination: NotificationSettingsView()) {
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
          
          NavigationLink(destination: WidgetsSettingsView()) {
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
}
