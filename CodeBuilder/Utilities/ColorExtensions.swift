//
//  ColorExtensions.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/27/24.
//

import SwiftUI

extension Color {
    static var cardBackground: Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor.secondarySystemBackground
            default:
                return UIColor.systemGray5 // Slightly darker in light mode
            }
        })
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel.shared)
}
