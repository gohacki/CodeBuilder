//
//  SplashScreenView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/24/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false // tracks whether to transition to the main content view
    @Environment(\.colorScheme) var colorScheme // detects the current color scheme (light/dark)

    var body: some View {
        if isActive {
            ContentView() // transition to the main content view
        } else {
            VStack {
                // displays the app's logo
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(40)

                // displays the app's title
                Text("CodeBuilder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // centers content
            .background(
                // adds a gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea() // extends gradient to fill the screen
            )
            .onAppear {
                // transitions to the main content view after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
  SplashScreenView() // previews the splash screen
}
