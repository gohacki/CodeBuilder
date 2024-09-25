//
//  GeneralSettignsView.swift
//  CodeBuilder
//
//  Created by Aaron Perkel on 9/25/24.
//

import SwiftUICore
import SwiftUI

struct GeneralSettingsView: View {
    var body: some View {
      NavigationStack {
        Text("General Settings")
      }
      .navigationTitle("General")
      .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview{
    GeneralSettingsView()
}
