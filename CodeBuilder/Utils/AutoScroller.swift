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
    @GestureState private var translation: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack {
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
                          .contentShape(Rectangle())
                          .onTapGesture {
                            path.append(tabItems[index].destination)
                          }
                      }
                  }
                .offset(x: -CGFloat(currentIndex) * geometry.size.width + translation)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture()
                        .updating($translation) { value, state, _ in
                            state = value.translation.width
                        }
                        .onEnded { value in
                            let offset = value.translation.width / geometry.size.width
                            let predictedOffset = value.predictedEndTranslation.width / geometry.size.width
                            let threshold: CGFloat = 0.2
                          
                          let newIndex: Int
                          if offset < -threshold || predictedOffset < -threshold {
                            newIndex = min(currentIndex + 1, tabItems.count - 1)
                          } else if offset > threshold || predictedOffset > threshold {
                            newIndex = max(currentIndex - 1, 0)
                          } else {
                            newIndex = currentIndex
                          }
                          withAnimation(.easeOut) {
                            currentIndex = newIndex
                          }
                        }
                )
                .animation(.interactiveSpring(), value: translation == 0)

                // Page Indicator
                HStack {
                    ForEach(tabItems.indices, id: \.self) { index in
                        Capsule()
                            .fill(Color.primary.opacity(currentIndex == index ? 1 : 0.33))
                            .frame(width: 45, height: 8)
                            .onTapGesture {
                                withAnimation {
                                    currentIndex = index
                                }
                            }
                    }
                }
                .padding(.top, 10)
            }
        }
        .frame(height: 200)
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
