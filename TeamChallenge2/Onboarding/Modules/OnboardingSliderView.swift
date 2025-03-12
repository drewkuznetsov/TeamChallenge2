//
//  OnboardingSliderView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//


import SwiftUI

struct OnboardingSliderView: View {
    @Binding var selected: UUID?
    let cards: [OnboardingModel]
    let onComplete: () -> Void

    var body: some View {
        TabView(selection: $selected) {
            ForEach(cards) { card in
                OnboardinCardView(card: card, action: onComplete)
                    .tag(card.id)
                    
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxHeight: 600)
        .shadow(color: .black.opacity(0.16), radius: 18.5, x: 0, y: 10)
    }
}
