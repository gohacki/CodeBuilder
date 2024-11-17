//
//  SearchBar.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/26/24.
//

import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  @State private var isEditing = false

  var body: some View {
    HStack {
      // Search field
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundColor(.gray)
          .padding(.leading, 8)

        TextField("Search Blocks", text: $text, onEditingChanged: { editing in
          withAnimation {
            self.isEditing = editing
          }
        })
        .foregroundColor(.primary)
        .autocapitalization(.none)
        .disableAutocorrection(true)

        if !text.isEmpty {
          Button(action: {
            self.text = ""
          }) {
            Image(systemName: "multiply.circle.fill")
              .foregroundColor(.gray)
          }
          .padding(.trailing, 8)
          .transition(.opacity)
        }
      }
      .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
      .background(Color(.systemGray6))
      .cornerRadius(10.0)

      if isEditing {
        Button(action: {
          withAnimation {
            self.isEditing = false
            self.text = ""
            hideKeyboard()
          }
        }) {
          Text("Cancel")
        }
        .padding(.leading, 5)
        .transition(.move(edge: .trailing))
      }
    }
    .padding(.horizontal)
  }
}

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif

#Preview {
  SearchBar(text: .constant(""))
}
