//
//  OnboardingPageModel.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//


import SwiftUI

struct OnboardingPageModel: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    var imageAlignment: Alignment = .top
    let title: String
    let description: String
    var nextButton: Bool = false
}

extension OnboardingPageModel {
    static var all: [OnboardingPageModel] = [
        OnboardingPageModel(
            imageName: "slide1",
            title: "Welcome",
            description: "Discover a fast and easy way to shop online."
        ),
        OnboardingPageModel(
            imageName: "slide2",
            title: "Smart Search & Favorites",
            description: "Find products instantly and save favorites for later."
        ),
        OnboardingPageModel(
            imageName: "slide3",
            title: "Connect",
            description: "Connect with friends and share your experiences with the community."
        ),
        OnboardingPageModel(
            imageName: "slide4",
            imageAlignment: .center,
            title: "Manage Your Store",
            description: "Become a manager, add products, and control your catalog!",
            nextButton: true
        ),
    ]
}
