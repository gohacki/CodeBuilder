//
//  HomeView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()
                Text("Welcome to CodeBuilder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
                NavigationLink(destination: ProblemsView()) {
                    Text("Problems")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: LearningView()) {
                    Text("Learning")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

#Preview{
    HomeView()
}
