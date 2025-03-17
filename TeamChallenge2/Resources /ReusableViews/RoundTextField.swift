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
    @State private var isHide: Bool = true
    
    let placeholder: String
    let onSubmit: () -> Void
    let height: CGFloat
    let fontSize: CGFloat
    let backgroundColor: Material
    let isHiddeble: Bool
    
    var field: some View {
        Group {
            if isHide && isHiddeble {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
    }
    
    var body: some View {
        HStack{
            field
                .autocorrectionDisabled(true)
                .keyboardType(.emailAddress)
                .font(Font.system(size: fontSize).weight(.medium))
                .foregroundStyle(Color.gray)
                .padding(.horizontal, height/2)
                .submitLabel(.done)
                .focused($fieldIsFocused)
                .onSubmit {
                    onSubmit()
                    fieldIsFocused = false
                }
            
            if isHiddeble {
                Button(action: { isHide.toggle() }) {
                    Image(systemName: isHide ? "eye.slash" : "eye")
                        .foregroundColor(Color.gray)
                }
                .padding(.horizontal, height/2)
            }
        }
        .frame(height: height)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: height/2))
    }
}
