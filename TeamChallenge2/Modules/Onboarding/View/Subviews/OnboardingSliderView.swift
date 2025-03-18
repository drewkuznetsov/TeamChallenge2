//
//  OnboardingSliderView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//


import SwiftUI

struct OnboardingSliderView: View {
    
    private enum Draving {
        static var shadowColor: Color { .black.opacity(0.16) }
        static var shadowRadius: CGFloat { 18.5 }
        static var shadowOffsetY: CGFloat { 10 }
    }
    
    @Binding var selected: UUID?
    let cards: [Onboarding]
    let onComplete: () -> Void
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(cards) { card in
                OnboardingCardView(
                    card: card,
                    action: onComplete
                )
                .tag(card.id)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .shadow(
            color: Draving.shadowColor,
            radius: Draving.shadowRadius,
            y: Draving.shadowOffsetY
        )
    }
}

#Preview {
    OnboardingView()
}
