//
//  CardButton.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//

import SwiftUI

struct CardButton: View {
    var action: () -> Void
    var title: String?
    
    private enum Drawing {
        static var cornerRadius: CGFloat { 16 }
        static var maxWidth: CGFloat { 200 }
    }
    
    var body: some View {
        Button(action: action) {
            Text(title ?? "Next")
                .padding(.horizontal)
                .frame(minWidth: Drawing.maxWidth)
        }
        .font(.title2.weight(.light))
        .buttonStyle(.borderedProminent)
        .tint(.accentColor)
        .clipShape(
            RoundedRectangle(cornerRadius: Drawing.cornerRadius)
        )
    }
}
