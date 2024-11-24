//
//  SplashScreenView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/24/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
              Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("CodeBuilder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .onAppear {
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
  SplashScreenView()
}
