//
//  ArticleDetailView.swift
//  CodeBuilder
//
//  Created by Miro Gohacki on 9/24/24.
//

import SwiftUICore
import SwiftUI

struct ArticleDetailView: View {
    let articleTitle: String

    var body: some View {
        ScrollView {
            Text(getArticleContent())
                .padding()
        }
        .navigationTitle(articleTitle)
    }

    func getArticleContent() -> String {
        switch articleTitle {
        case "Introduction to Arrays":
            return "Arrays are collections of elements..."
        case "Understanding Recursion":
            return "Recursion is a method where the solution..."
        default:
            return "Content not available."
        }
    }
}

#Preview {
  ArticleDetailView(articleTitle: "Preview")
}
