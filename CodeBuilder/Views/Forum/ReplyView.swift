//
//  ReplyView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/25/24.
//

import SwiftUI

struct ReplyView: View {
    var reply: Reply // the reply data model

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // user avatar with a user-specific color
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(UserColor.color(for: reply.userID))

            VStack(alignment: .leading, spacing: 4) {
                Text(reply.displayName) // user's name
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Text(reply.content) // reply content
                    .font(.body)
                Text(reply.timestamp, style: .time) // formatted timestamp
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer() // pushes content to the left
        }
        .padding(.vertical, 8) // vertical padding for spacing
    }
}
