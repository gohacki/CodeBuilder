//
//  CarouselCard.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/27/24.
//

import SwiftUI

struct CarouselCard: View {
    let tabItem: TabItem
    let cardWidth: CGFloat
    @Binding var path: NavigationPath
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: tabItem.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
                .foregroundColor(.white)
                .padding()
                .background(tabItem.color)
                .clipShape(Circle())

            Text(tabItem.title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(width: cardWidth - 50)
        .padding(25)
        // Remove internal padding
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
                .shadow(
                    color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.1),
                    radius: 8, x: 0, y: 4
                )
        )
        .onTapGesture {
            path.append(tabItem.destination)
        }
    }
}


// Preview
#Preview {
    // Sample data for the tabItem
    let sampleTabItem = TabItem(
        title: "Sample Title",
        color: .blue,
        iconName: "star.fill",
        destination: .problems
    )
    
    // Provide a constant binding for the path
    let samplePath = Binding.constant(NavigationPath())
    
    // Provide a sample cardWidth
    let sampleCardWidth: CGFloat = 300
    
    return CarouselCard(
        tabItem: sampleTabItem,
        cardWidth: sampleCardWidth,
        path: samplePath
    )
    .frame(height: 220)
}
