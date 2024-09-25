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
      List {
        
        Section {
          TextField("Search", text: $searchText)
        }
        
        Section {
          NavigationLink(destination: ProblemsView()) {
            HStack {
              Image(systemName: "person.fill")
                .foregroundColor(.blue)
              Text("aaron perkel")
            }
          }
        }
        .padding(.top, 15)
        .padding(.bottom, 15)
        
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
