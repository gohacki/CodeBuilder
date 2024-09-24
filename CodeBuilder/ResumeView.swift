//
//  ResumeView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct ResumeView: View {
    let articles = ["Introduction to Arrays", "Understanding Recursion"]

    var body: some View {
        List(articles, id: \.self) { article in
            NavigationLink(destination: ArticleDetailView(articleTitle: article)) {
                Text(article)
                    .font(.headline)
            }
        }
        .navigationTitle("Resume Tips")
    }
}
