//
//  LearningView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct LearningView: View {
    // list of articles to display
    let articles = [
        "Hello World",
        "Introduction To Arrays",
        "Understanding Recursion",
        "Arithmetic Operations",
        "String Manipulations",
        "Array Manipulations",
        "Understanding Big O Notation",
        "Two Pointer Technique",
        "Depth First Search",
        "Breadth First Search",
        "Introduction To Linked Lists",
        "Linked List Manipulations",
        "Searching And Sorting",
        "Sliding Window"
    ]

    var body: some View {
        GradientBackgroundView {
            List(articles, id: \.self) { article in
                NavigationLink(destination: ArticleDetailView(articleTitle: article)) {
                    Text(article)
                        .font(.headline)
                }
            }
            .background(Color.clear) // removes the default list background
            .scrollContentBackground(.hidden) // hides the background color behind the list
            .navigationTitle("Learning")
        }
    }
}
