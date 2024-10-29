//
//  AutoScroller.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/26/24.
//

import SwiftUI

// TabItem struct for AutoScroller
struct TabItem {
    let title: String
    let color: Color
    let iconName: String
    let destination: TabDestination
}

// Enum for destinations in AutoScroller
enum TabDestination: Hashable {
    case problems
    case learning
    case resumeTips
}

struct AutoScroller: View {
    let tabItems: [TabItem] = [
        TabItem(title: "Problems", color: .blue, iconName: "doc.text.fill", destination: .problems),
        TabItem(title: "Learning", color: .orange, iconName: "book.fill", destination: .learning),
        TabItem(title: "Resume Tips", color: .brown, iconName: "briefcase.fill", destination: .resumeTips)
    ]
    @Binding var path: NavigationPath
    @Environment(\.colorScheme) var colorScheme
    @State private var currentIndex: Int = 0
    @State private var offset: CGFloat = 0

    var body: some View {
        VStack(spacing: 20) {
            // Carousel
            GeometryReader { geometry in
                let spacing: CGFloat = 16
                let cardWidth = geometry.size.width * 0.8
                let totalSpacing = spacing * CGFloat(tabItems.count - 1)
                let totalWidth = CGFloat(tabItems.count) * cardWidth + totalSpacing

                // Compute xOffset separately
                let baseOffset = -CGFloat(currentIndex) * (cardWidth + spacing)
                let centeringOffset = (geometry.size.width - cardWidth) / 2
                let xOffset = baseOffset + centeringOffset + offset

                HStack(spacing: spacing) {
                    ForEach(tabItems.indices, id: \.self) { index in
                        let tabItem = tabItems[index]
                        CarouselCard(
                            tabItem: tabItem,
                            cardWidth: cardWidth,
                            path: $path
                        )
                    }
                }
                .frame(width: totalWidth, alignment: .leading)
                .offset(x: xOffset)
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
            .frame(height: 220)
            .padding(.horizontal)

            // Page Indicator
            HStack(spacing: 8) {
                ForEach(tabItems.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.primary.opacity(currentIndex == index ? 1 : 0.3))
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                currentIndex = index
                            }
                        }
                }
            }
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
