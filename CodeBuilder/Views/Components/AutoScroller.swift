import SwiftUI

// TabItem struct for AutoScroller
struct TabItem {
    let title: String // name of the tab
    let color: Color // background color for the card
    let iconName: String // SF Symbol for the card
    let destination: TabDestination // navigation destination
}

// Enum for carousel destinations
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

    @Binding var path: NavigationPath // navigation state
    @Environment(\.colorScheme) var colorScheme // light/dark mode
    @State private var currentIndex: Int = 0 // current visible tab index
    @State private var offset: CGFloat = 0 // swipe offset

    var body: some View {
        VStack(spacing: 20) {
            // carousel section
            GeometryReader { geometry in
                let cardWidth = geometry.size.width * 0.8
                let spacing: CGFloat = 16
                let totalSpacing = spacing * CGFloat(tabItems.count - 1)
                let totalWidth = CGFloat(tabItems.count) * cardWidth + totalSpacing

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
                            offset = value.translation.width // track swipe distance
                        }
                        .onEnded { value in
                            let threshold = geometry.size.width / 4
                            var newIndex = currentIndex

                            // determine new index based on swipe
                            if -value.translation.width > threshold {
                                newIndex = min(currentIndex + 1, tabItems.count - 1)
                            } else if value.translation.width > threshold {
                                newIndex = max(currentIndex - 1, 0)
                            }

                            // reset offset and update index with animation
                            withAnimation(.easeOut) {
                                offset = 0
                                currentIndex = newIndex
                            }
                        }
                )
            }
            .frame(height: 175)
            .padding(.horizontal)

            // page indicator
            HStack(spacing: 8) {
                ForEach(tabItems.indices, id: \.self) { index in
                    Circle()
                        .fill(Color.primary.opacity(currentIndex == index ? 1 : 0.3)) // highlight current index
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                currentIndex = index // navigate to tapped index
                            }
                        }
                }
            }
            .padding(.top, 120)
        }
    }
}
