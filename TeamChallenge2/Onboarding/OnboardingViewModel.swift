//
//  OnboardingViewModel.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

class OnboardingViewModel: ObservableObject {
    // Используем CoreData через обертку @AppStorage для сохранения состояния завершения онбординга
    @AppStorage("OnboardingCompleted") private var onboardingCompleted: Bool = false
    @Published var all = OnboardingModel.all
    @Published var selected: UUID?
    
    // Проверка, завершён ли онбординг - пока не используем
    var isOnboardingCompleted: Bool {
        onboardingCompleted
    }
    
    // Метод для завершения онбординга
    func completeOnboarding() {
        onboardingCompleted = true
        debugPrint(#line, #function, "Onboarding Completed", #file)
    }
    
    func setSelected() {
        guard let id = all.first?.id else { return }
        selected = id
    }
}
