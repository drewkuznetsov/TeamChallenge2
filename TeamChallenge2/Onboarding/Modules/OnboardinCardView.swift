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

    var body: some View {
        VStack {
            Image(card.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 326, minHeight: 338, alignment: card.imageAlignment)
                .clipped()

            VStack {
                Text(card.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Text(card.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)

                Spacer()

                if card.nextButton {
                    Button(action: action) {
                        Text("Начать")
                            .padding(5)
                            .frame(minWidth: 200)
                    }
                    .font(.title2.weight(.light))
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .tint(.accentColor)
                }
            }
            .padding(20)
        }
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: 326)
    }
}
