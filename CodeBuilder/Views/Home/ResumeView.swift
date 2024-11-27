//
//  ResumeView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct ResumeView: View {
    let articles = ["Resume Topics", "How to Write a Cover Letter", "STAR Bullet Point Method", "Cover Letter Header Example", "Questions for the Interviewer", "Resume Header", "Common Behavioral Interview Questions", "Common Technical Interview Questions"]

  var body: some View {
    GradientBackgroundView{
      List(articles, id: \.self) { article in
        NavigationLink(destination: ResumeDetailView(articleTitle: article)) {
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
