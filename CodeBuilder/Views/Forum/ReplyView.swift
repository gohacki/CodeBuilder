//
//  ReplyView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 11/25/24.
//

import SwiftUI


struct ReplyView: View {
    var reply: Reply

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
          Image(systemName: "person.circle.fill")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(UserColor.color(for: reply.userID)) // Apply user-specific color

            VStack(alignment: .leading, spacing: 4) {
                Text(reply.displayName)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Text(reply.content)
                    .font(.body)
                Text(reply.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
