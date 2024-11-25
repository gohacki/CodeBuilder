//
//  LearningView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct LearningView: View {
    let articles = ["Hello World, Introduction To Arrays", "Understanding Recursion", "Arithmetic Operations", "String Manipulations", "Array Manipulations", "Linked List Manipulations", "Search And Sorting", "Sliding Window"]

    var body: some View {
        List(articles, id: \.self) { article in
            NavigationLink(destination: ArticleDetailView(articleTitle: article)) {
                Text(article)
                    .font(.headline)
            }
        }
        .navigationTitle("Learning")
    }
}
