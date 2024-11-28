//
//  BackgroundGradientModifier.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/24/24.
//


import SwiftUI

struct BackgroundGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
    }
}

extension View {
    func applyBackgroundGradient() -> some View {
        self.modifier(BackgroundGradientModifier())
    }
}
