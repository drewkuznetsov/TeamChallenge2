//
//  ColorRectangleView.swift
//  TeamChallenge2
//
//  Created by nikita on 12.03.25.
//

import SwiftUI

struct ColorRectangleView: View {
    let cornerRadius: CGFloat
    let text: String
    let height: CGFloat
    let backgroundColor: Color
    let textColor: Color
    let fontSize: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(backgroundColor)
            .frame(height: height)
            .overlay {
                Text(text)
                    .font(Font.system(size: fontSize))
                    .foregroundStyle(textColor)
            }
    }
}
