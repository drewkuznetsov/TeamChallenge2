//
//  TeamChallenge2App.swift
//  TeamChallenge2
//
//  Created by Андрей Кузнецов on 03.03.2025.
//

import SwiftUI

@main
struct TeamChallenge2App: App {
    @StateObject private var viewModel = RootViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            switch viewModel.currentScreen {
            case .onbording:
                OnboardingView()
            case .login:
                StartView()
            case .home:
                TabBarView()
            }
        }
    }
}
