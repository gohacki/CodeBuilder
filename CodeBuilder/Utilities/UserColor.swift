//
//  UserColor.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/27/24.
//


// Utilities/UserColor.swift

import SwiftUI

struct UserColor {
    // Define a palette of distinct colors
    static let colors: [Color] = [
        .red, .orange, .yellow, .green, .blue,
        .purple, .pink, .teal, .indigo, .cyan
    ]
    
    /// Returns a color based on the user's unique identifier.
    static func color(for userID: String) -> Color {
        // Generate a consistent hash from the userID
        let hash = abs(userID.hashValue)
        // Map the hash to an index within the colors array
        let index = hash % colors.count
        return colors[index]
    }
}