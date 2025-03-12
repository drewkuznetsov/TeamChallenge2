//
//  OnboardingView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
                .equatable()
            
            VStack() {
                
                OnboardingSliderView(
                    selected: $viewModel.selectedCard,
                    cards: viewModel.allCards,
                    onComplete: viewModel.completeOnboarding
                )
                
                ProgressIndicatorView(
                    cards: viewModel.allCards.map(\.id),
                    selected: $viewModel.selectedCard
                )
            }
        }
        .onAppear { viewModel.setSelected() }
    }
}

#Preview {
    OnboardingView()
}
