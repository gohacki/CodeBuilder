//
//  HomeView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/25/24.
//

import SwiftUI

// Home Page
struct HomeView: View {
  @State private var currentIndex = 0
  let tabItems: [(String, Color, AnyView)] = [
    ("Problems", Color.blue, AnyView(ProblemsView())),
    ("Learning", Color.orange, AnyView(LearningView())),
    ("Resume Tips", Color.brown, AnyView(ResumeView()))
  ]
  
  var body: some View {
    NavigationStack {
      VStack {
        Text("Hello, Aaron")
          .font(.headline)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        AutoScroller(tabItems: tabItems)
          .frame(height: 200)
      
        List {
          Text("Maybe here we can have like")
          Text("stats or some other useful info")
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
      }
    }
  }
}

// https://github.com/adityagi02/carousel-view-swiftUI
struct AutoScroller: View {
  let tabItems: [(String, Color, AnyView)]
  // let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
  @State private var selectedTabIndex = 0
  
  var body: some View {
    ZStack {
      TabView(selection: $selectedTabIndex) {
        ForEach(0..<tabItems.count, id: \.self) { index in
          ZStack(alignment: .topLeading) {
            NavigationLink(destination: tabItems[index].2) {
              VStack {
                Image(systemName: tabIcon(for: tabItems[index].0))
                  .resizable()
                  .scaledToFit()
                  .frame(height: 100)
                  .foregroundStyle(tabItems[index].1)
                  .tag(index)
                Text(tabItems[index].0)
                  .font(.headline)
                  .foregroundStyle(Color.primary)
              }
              .padding(.bottom, 20)
            }
          }
          .shadow(radius: 20)
        }
      }
      .frame(height: 200)
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
      
      HStack {
        ForEach(0..<tabItems.count, id: \.self) { index in
          Capsule()
            .fill(Color.primary.opacity(selectedTabIndex == index ? 1 : 0.33))
            .frame(width: 45, height: 8)
            .onTapGesture {
              selectedTabIndex = index
            }
        }
        .offset(y: 95)
      }
    }
    /* timer
    .onReceive(timer) { _ in
      withAnimation(.default) {
        selectedTabIndex = (selectedTabIndex + 1) % tabItems.count
      }
    }
     */
  }
  
  func tabIcon(for tabItem: String) -> String {
    switch tabItem {
    case "Problems":
        return "doc.text.fill"
    case "Learning":
        return "book.fill"
    case "Resume Tips":
        return "briefcase.fill"
    default:
        return "questionmark"
    }
  }
}

#Preview {
  HomeView()
}
