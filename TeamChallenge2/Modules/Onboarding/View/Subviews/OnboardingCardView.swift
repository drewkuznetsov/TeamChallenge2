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

    var body: some View {
        image
            .overlay(alignment: .bottom) {
                    bottomView
            }

    }
    
    private var image: some View {
        Image(card.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: maxWidth)
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
            .frame(width: maxWidth, height: maxWidth)
    }
}

extension OnboardingCardView {
    private enum Drawing {
        static var sideInset: CGFloat { 24 }
        static var cornerRadius: CGFloat { 20 }
    }
}

#Preview {
    OnboardingView()
}
