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
    GradientBackgroundView{
      List(articles, id: \.self) { article in
        NavigationLink(destination: ArticleDetailView(articleTitle: article)) {
          Text(article)
            .font(.headline)
        }
      }
      .background(Color.clear)
      .scrollContentBackground(.hidden)
      .navigationTitle("Resume Tips")
    }
  }
}

#Preview {
  ResumeView()
}
