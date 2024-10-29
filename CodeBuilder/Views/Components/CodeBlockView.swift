//
//  CodeBlockView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/28/24.
//

import SwiftUI

struct CodeBlockView: View {
    let code: String
    let backgroundColor: Color

    var body: some View {
        Text(code)
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.primary)
            .padding()
            .background(backgroundColor)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .onDrag {
                NSItemProvider(object: code as NSString)
            }
    }
}
