// SplashScreenView.swift
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
            .background(Color(UIColor.systemBackground))
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