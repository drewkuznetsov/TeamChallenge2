//
//  OnboardingSliderView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//


import SwiftUI

struct OnboardingSliderView: View {
    @Binding var selected: UUID?
    let pages: [OnboardingModel]
    let onComplete: () -> Void

    var body: some View {
        TabView(selection: $selected) {
            ForEach(pages) { page in
                OnboardingPageView(page: page, action: onComplete)
                    .tag(page.id)
                    
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding(0)
        .frame(maxHeight: 614)
        .shadow(color: .black.opacity(0.16), radius: 18.5, x: 0, y: 10)
    }
}