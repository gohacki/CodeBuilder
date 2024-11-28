//
//  CarouselCard.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/27/24.
//

import SwiftUI

struct CarouselCard: View {
    let tabItem: TabItem // data for the card
    let cardWidth: CGFloat // width of the card
    @Binding var path: NavigationPath // navigation path for transitioning to new views
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 16) {
            // icon for the card
            Image(systemName: tabItem.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
                .foregroundColor(.white)
                .padding()
                .background(tabItem.color) // icon background color
                .clipShape(RoundedRectangle(cornerRadius: 16))

            // card title
            Text(tabItem.title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(width: cardWidth - 50, height: 250)
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
                .shadow(
                    color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.1),
                    radius: 8, x: 0, y: 4
                )
        )
        .onTapGesture {
            path.append(tabItem.destination) // navigate when tapped
        }
    }
}

// Preview
#Preview {
    // sample data for testing the card
    let sampleTabItem = TabItem(
        title: "Sample Title",
        color: .blue,
        iconName: "star.fill",
        destination: .problems
    )
    
    let samplePath = Binding.constant(NavigationPath()) // mock navigation path
    let sampleCardWidth: CGFloat = 300 // mock card width

    return CarouselCard(
        tabItem: sampleTabItem,
        cardWidth: sampleCardWidth,
        path: samplePath
    )
    .frame(height: 220) // fixed height for preview
}
