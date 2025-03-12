//
//  OnboardingView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var pagesVM = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            // Фон
            BackgroundView()
                .equatable()
            
            // Контент
            VStack(spacing: 10) {
                
                // Слайдер
                OnboardingSliderView(
                    selected: $pagesVM.selected,
                    pages: pagesVM.all,
                    onComplete: pagesVM.completeOnboarding
                )
                
                // Индикация слайдера
                ProgressIndicatorView(
                    pages: pagesVM.all.map(\.id),
                    selected: $pagesVM.selected
                )
            }
        }
        .onAppear { pagesVM.setSelected }
    }
}

#Preview {
    OnboardingView()
}
