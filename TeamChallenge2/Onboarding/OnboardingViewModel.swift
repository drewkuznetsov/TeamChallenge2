//
//  OnboardingViewModel.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    @AppStorage("isOnboardingCompleted")
    var isOnboardingCompleted: Bool = false
    
    @Published var allCards = OnboardingModel.allCards
    @Published var selectedCard: UUID?
    
    func completeOnboarding() {
        isOnboardingCompleted = true
    }
    
    func setSelected() {
        guard let id = allCards.first?.id else { return }
        selectedCard = id
    }
}
