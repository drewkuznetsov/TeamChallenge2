//
//  OnboardingPageView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPageModel
    @ObservedObject var onboardingVM: OnboardingViewModel  // Добавляем @ObservedObject

    var body: some View {
        VStack {
            Image(page.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 326, minHeight: 338, alignment: page.imageAlignment)
                .clipped()

            VStack {
                Text(page.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                Text(page.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)

                Spacer()

                if page.nextButton {
                    Button {
                        // Вызываем метод завершения онбординга через onboardingVM
                        onboardingVM.completeOnboarding()
                    } label: {
                        Text("Начать")
                            .padding(5)
                            .frame(minWidth: 200)
                    }
                    .font(.title2)
                    .fontWeight(.light)
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .tint(.accentColor)
                }
            }
            .padding(20)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: 326)
    }
}