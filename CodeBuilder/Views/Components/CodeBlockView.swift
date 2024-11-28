//
//  CodeBlockView.swift
//  CodeBuilder
//
//  Created by aaron perkel on 10/28/24.
//

import SwiftUI

struct CodeBlockView: View {
    let code: String // the code to display
    let backgroundColor: Color // background color for the block

    var body: some View {
        Text(code)
            .font(.system(.body, design: .monospaced)) // monospaced font for code readability
            .foregroundColor(.primary)
            .padding()
            .background(backgroundColor) // customizable background color
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5) // border styling
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .onDrag { // enables drag-and-drop functionality
                NSItemProvider(object: code as NSString)
            }
    }
}

#Preview {
    CodeBlockView(code: "print(\"Hello World\")", backgroundColor: Color.blue.opacity(0.1))
        .frame(width: 150, height: 50) // fixed frame for preview
}
