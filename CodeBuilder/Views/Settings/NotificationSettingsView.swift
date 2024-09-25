//
//  NotificationSettingsView.swift
//  CodeBuilder
//
//  Created by Aaron Perkel on 9/25/24.
//

import SwiftUICore
import SwiftUI

struct NotificationSettingsView: View {
    var body: some View {
      NavigationStack {
        Text("Notification Settings")
      }
      .navigationTitle("Notifications")
      .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview{
    NotificationSettingsView()
}
