//
//  PostView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/25/24.
//

import SwiftUI

struct PostView: View {
    var post: Post
    @State private var isReplying: Bool = false // tracks whether the reply input is visible
    @EnvironmentObject var forumViewModel: ForumViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // header with user avatar, name, and timestamp
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(UserColor.color(for: post.userID))
                VStack(alignment: .leading) {
                    Text(post.displayName)
                        .font(.headline)
                    Text(post.timestamp, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }

            // post title
            Text(post.title)
                .font(.body)
                .padding(.vertical, 4)

            // actions like replying
            HStack {
                Button(action: {
                    isReplying.toggle()
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left.2.fill")
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

            // list of replies
            if !post.replies.isEmpty {
                Divider()
                ForEach(post.replies) { reply in
                    ReplyView(reply: reply)
                }
            }

            // inline reply input
            if isReplying {
                InlineReplyView(post: post) {
                    isReplying = false // close the reply input after submitting
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
