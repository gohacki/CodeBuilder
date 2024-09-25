//
//  WidgetsSettingsView.swift
//  CodeBuilder
//
//  Created by Aaron Perkel on 9/25/24.
//

import SwiftUICore
import SwiftUI

struct WidgetsSettingsView: View {
    var body: some View {
      NavigationStack {
        Text("Widgets Settings")
      }
      .navigationTitle("Widgets")
      .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview{
    WidgetsSettingsView()
}
