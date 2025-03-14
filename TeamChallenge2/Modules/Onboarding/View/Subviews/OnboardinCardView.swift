//
//  OnboardingPageView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

struct OnboardinCardView: View {
    
    let card: Onboarding
    let action: () -> Void
    
    private enum Draving {
        static var size: CGFloat { 340 }
        static var padding: CGFloat { 20 }
        static var cornerRadius: CGFloat { 20 }
    }

    var body: some View {
        VStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(
                    minHeight: Draving.size,
                    alignment: card.imageAlignment)
                .clipped()

            VStack {
                Text(card.title)
                    .font(.sectionHeader)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, Draving.padding)

                Text(card.description)
                    .font(.bodyLight)
                    .multilineTextAlignment(.center)

                Spacer()

                if let title = card.buttonTitle {
                    OnboardingCardButton(
                        action: action,
                        title: title
                    )
                }
            }
            .padding(Draving.padding)
        }
        .frame(maxWidth: Draving.size)
        .background(Color(UIColor.systemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: Draving.cornerRadius)
        )

    }
}

#Preview {
    OnboardingView()
}
