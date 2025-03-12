//
//  ProgressIndicator.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//


import SwiftUI

struct ProgressIndicatorView: View {
    @State var cards: [UUID]
    @Binding var selected: UUID?
    
    private var size: CGFloat { 20 }
    
    var body: some View {
        HStack(spacing: size) {
            ForEach(cards, id: \.self) { card in
                Circle()
                    .fill(
                        card == selected
                        ? Color.accentColor
                        : Color.accentColor.opacity(0.2))
                    .frame(width: size, height: size)
                    .onTapGesture {
                        selected = card
                    }
            }
        }
        .padding(size)
    }
}
