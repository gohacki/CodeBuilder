//
//  AutoScroller.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/26/24.
//

import SwiftUI

struct AutoScroller: View {
    let tabItems: [TabItem]
    @Binding var path: NavigationPath
    @State private var currentIndex: Int = 0
    @State private var offset: CGFloat = 0 // Offset for the swipe gesture

    var body: some View {
        VStack(spacing: 0) { // Remove default spacing
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(tabItems.indices, id: \.self) { index in
                        VStack {
                            Image(systemName: tabIcon(for: tabItems[index].title))
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .foregroundStyle(tabItems[index].color)
                            Text(tabItems[index].title)
                                .font(.headline)
                                .foregroundStyle(Color.primary)
                        }
                        .frame(width: geometry.size.width)
                        .contentShape(Rectangle()) // Make the entire area tappable
                        .onTapGesture {
                            path.append(tabItems[index].destination)
                        }
                    }
                }
                .offset(x: -CGFloat(currentIndex) * geometry.size.width + offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold = geometry.size.width / 4
                            var newIndex = currentIndex
                            
                            if -value.translation.width > threshold {
                                newIndex = min(currentIndex + 1, tabItems.count - 1)
                            } else if value.translation.width > threshold {
                                newIndex = max(currentIndex - 1, 0)
                            }
                            
                            withAnimation(.easeOut) {
                                offset = 0
                                currentIndex = newIndex
                            }
                        }
                )
            }
            .frame(height: 150) // Set a fixed height for the main content

            // Page Indicator
            HStack {
                ForEach(tabItems.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.primary.opacity(currentIndex == index ? 1 : 0.33))
                        .frame(width: 45, height: 8)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                currentIndex = index
                            }
                        }
                }
            }
            .frame(height: 30) // Set a fixed height for the page indicator
        }
        .frame(height: 150) // Set the total height of the AutoScroller
        .padding(.top, 30)
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

#Preview{
    HomeView()
}

