//
//  OnboardingViewModel.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @Published var allCards = Onboarding.allCards
    @Published var selectedCard: UUID?
    
    func completeOnboarding() {
        RootViewModel.shared.completeOnboarding()
    }
    
    func setSelected() {
        guard let id = allCards.first?.id else { return }
        selectedCard = id
    }
}
