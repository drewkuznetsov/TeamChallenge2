//
//  OnboardingPageView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

struct OnboardinCardView: View {
    
    let card: OnboardingModel
    let action: () -> Void
    
    private enum Draving {
        static var maxWidth: CGFloat { 326 }
        static var imageMinHeight: CGFloat { 338 }
        static var padding: CGFloat { 20 }
        static var cornerRadius: CGFloat { 20 }
    }

    var body: some View {
        VStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(
                    minHeight: Draving.imageMinHeight,
                    alignment: card.imageAlignment)
                .clipped()

            VStack {
                Text(card.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(.bottom, Draving.padding)

                Text(card.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)

                Spacer()

                if card.hasNextButton {
                    OnboardingCardButton(
                        action: action,
                        title: card.title
                    )
                }
            }
            .padding(Draving.padding)
        }
        .frame(maxWidth: Draving.maxWidth)
        .background(Color(UIColor.systemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: Draving.cornerRadius)
        )

    }
}
