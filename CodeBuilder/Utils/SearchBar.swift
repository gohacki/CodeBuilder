//
//  SearchBar.swift
//  CodeBuilder
//
//  Created by aaron perkel on 9/26/24.
//


// THIS IS GLITCHY

import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  @State private var isEditing = false
  
  var body: some View {
    HStack {
      TextField("Search", text: $text)
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .overlay(
          HStack {
            Image(systemName: "magnifyingglass")
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 8)
            
            
            if isEditing && !text.isEmpty {
             Button(action: {
               self.text = ""
             }) {
               Image(systemName: "multiply.circle.fill")
                 .foregroundColor(.gray)
                 .padding(.trailing, 8)
             }
            }
          }
        )
        .onTapGesture {
          withAnimation {
            self.isEditing = true
          }
        }
        .padding(.horizontal, 10)
      if isEditing {
        Button(action: {
          withAnimation {
            self.isEditing = false
            self.text = ""
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

          }
        }) {
          Text("Cancel")
        }
        .padding(.trailing, 15)
        .transition(.move(edge: .trailing))
        .animation(.easeInOut, value: isEditing)
      }
    }
    .animation(.default, value: isEditing)
  }
}

#Preview {
  SearchBar(text: .constant(""))
}
