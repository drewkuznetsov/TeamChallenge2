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
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(cards, id: \.self) { card in
                Circle()
                    .fill(
                        card == selected
                        ? Color.accentColor
                        : Color.accentColor.opacity(0.2))
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        selected = card
                    }
            }
        }
        .padding(.bottom, 20)
    }
}
