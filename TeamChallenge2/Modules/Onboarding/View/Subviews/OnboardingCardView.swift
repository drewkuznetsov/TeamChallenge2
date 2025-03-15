//
//  OnboardingPageView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

struct OnboardingCardView: View {
    
    let card: Onboarding
    let action: () -> Void
    
    private var maxWidth: CGFloat {
        UIScreen.main.bounds.width - 2 * Drawing.sideInset
    }
    
    private var maxHeight: CGFloat {
        UIScreen.main.bounds.height - Drawing.topInset - Drawing.bottomInset
    }

    var body: some View {
        ZStack {
            Color.clear
                VStack(spacing: 0) {
                    image
                    bottomView
                }
                .clipShape(.rect(cornerRadius: 20))
        }
        .ignoresSafeArea()
    }
    
    private var image: some View {
        Image(card.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: maxWidth)
            .frame(height: maxHeight * 0.55 )
            .clipped()
        
    }
    
    private var bottomView: some View {
        Color.white
            .overlay {
                VStack {
                    Text(card.title)
                        .font(.sectionHeader)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 40, leading: 40, bottom: 16, trailing: 40))
                    
                    Text(card.description)
                        .font(.bodyLight)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    if let title = card.buttonTitle {
                        OnboardingCardButton(
                            action: action,
                            title: title
                        )
                        .padding(EdgeInsets(top: 23, leading: 62, bottom: 23, trailing: 62))
                    }
                }
            }
            .frame(width: maxWidth, height: maxHeight * 0.45 )
    }
}

extension OnboardingCardView {
    private enum Drawing {
        static var sideInset: CGFloat { 24 }
        static var cornerRadius: CGFloat { 20 }
        static var topInset: CGFloat { 81 }
        static var bottomInset: CGFloat { 117 }
    }
}

#Preview {
    OnboardingCardView(card: Onboarding.allCards[1], action: {})
}
