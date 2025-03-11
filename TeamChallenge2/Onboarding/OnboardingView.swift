//
//  OnboardingView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingVM = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            // Фон
            Image("bubbles")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Контент
            VStack(spacing: 10) {
                TabView(selection: $onboardingVM.currentIndex) {
                    ForEach(onboardingVM.onboardingPages) { page in
                        OnboardingPageView(page: page, onboardingVM: onboardingVM)
                            .tag(page.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                .padding(0)
                .frame(maxHeight: 614)
                .shadow(color: .black.opacity(0.16), radius: 18.5, x: 0, y: 10)
                
                HStack(spacing: 20) {
                    ForEach(onboardingVM.onboardingPages) { page in
                        Circle()
                            .fill(page.id == onboardingVM.currentIndex ? Color.accentColor : Color.accentColor.opacity(0.2))  // Исправлено сравнение
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(20)
            }
        }
        .onAppear {
            onboardingVM.currentIndex = onboardingVM.onboardingPages.first?.id
        }
    }
}

#Preview {
    OnboardingView()
}
