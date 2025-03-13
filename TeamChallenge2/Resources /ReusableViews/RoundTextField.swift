//
//  RoundTextField.swift
//  TeamChallenge2
//
//  Created by nikita on 13.03.25.
//

import SwiftUI

struct RoundTextField: View {
    @Binding var text: String
    @FocusState private var fieldIsFocused: Bool
    let placeholder: String
    let maxCount: Int
    let onSubmit: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                TextField(placeholder, text: $text)
                    .font(Font.system(size: 20).weight(.medium))
                    .foregroundStyle(Color.brown)
                    .padding(8)
                    .submitLabel(.done)
                    .focused($fieldIsFocused)
                    .onSubmit {
                        onSubmit()
                        fieldIsFocused = false
                    }
                    .onChange(of: text) { _, newValue in
                        if newValue.count > maxCount {
                            text = String(newValue.prefix(maxCount))
                        }
                    }
            }
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.green)
            )
            
            Text("\(text.count) / \(maxCount)")
                .font(Font.system(size: 14).weight(.thin))
                .foregroundStyle(Color.yellow)
                .lineLimit(1)
                .frame(width: 60, alignment: .trailing)
        }
    }
}
