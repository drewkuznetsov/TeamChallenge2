//
//  RootViewModel.swift
//  TeamChallenge2
//
//  Created by nikita on 16.03.25.
//

import Foundation
import ShoppeStore

final class RootViewModel: ObservableObject {
    static let shared = RootViewModel()
    
    enum Tab {
        case onbording
        case login
        case home
    }
    
    @Published var currentScreen: Tab = .onbording
    
    private init() {
        checkStatus()
        
        if ShoppeStore.shared.persistence.currentUser != nil {
            currentScreen = .home
        }
    }
    
    private func checkStatus() {
        if ShoppeStore.shared.persistence.isOnboarded {
            currentScreen = .login
        }
        if ShoppeStore.shared.persistence.currentUser != nil  {
            currentScreen = .home
        }
    }
    
    func completeOnboarding() {
        ShoppeStore.shared.persistence.isOnboarded = true
        currentScreen = .login
    }
    
    func login() {
        currentScreen = .home
    }
    
    func logout() {
        ShoppeStore.shared.persistence.currentUser = nil
        currentScreen = .login
    }
}
