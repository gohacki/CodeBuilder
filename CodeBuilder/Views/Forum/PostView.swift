//
//  PostView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/25/24.
//


import SwiftUI

struct PostView: View {
    var post: Post
    @State private var isReplying: Bool = false
    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text(post.displayName)
                        .font(.headline)
                    Text(post.timestamp, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }

            // Title
            Text(post.title)
                .font(.body)
                .padding(.vertical, 4)

            // Actions
            HStack {
              Button(action: {
                  isReplying.toggle()
              }) {
                  HStack {
                      Image(systemName: "arrowshape.turn.up.left.2.fill") // Updated icon
                      Text("Reply")
                  }
              }
                .buttonStyle(BorderlessButtonStyle())
                .foregroundColor(.blue)

                Spacer()

                Text("\(post.replies.count) Replies")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            // Replies
            if !post.replies.isEmpty {
                Divider()
                ForEach(post.replies) { reply in
                    ReplyView(reply: reply)
                }
            }

            // Reply Input
            if isReplying {
                InlineReplyView(post: post) {
                    isReplying = false
                }
                .environmentObject(forumViewModel)
                .environmentObject(authViewModel)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.vertical, 8)
    }
}
