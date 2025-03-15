//
//  OnboardingPageView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

struct OnboardingCardView: View {
    
    let card: OnboardingModel
    let action: () -> Void
    
    private var maxWidth: CGFloat {
        UIScreen.main.bounds.width - 2 * Drawing.sideInset
    }

    var body: some View {
        VStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .aspectRatio(1, contentMode: .fill)
                .clipped()

            VStack {
                Text(card.title)
                    .font(.sectionHeader)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(.bottom, Drawing.padding)

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
            .padding(Drawing.padding)
        }
        .frame(width: maxWidth)
        .background(Color(UIColor.systemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: Drawing.cornerRadius)
        )

    }
}

extension OnboardingCardView {
    private enum Drawing {
        static var sideInset: CGFloat { 25 }
        static var padding: CGFloat { 20 }
        static var cornerRadius: CGFloat { 20 }
    }
}

#Preview {
    OnboardingView()
}
