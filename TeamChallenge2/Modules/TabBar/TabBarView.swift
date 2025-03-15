//
//  TabBarView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//

import SwiftUI

struct TabBarView: View {
    private var tabs = TabBarItem.allCases
    @State private var selectedTab = 0
    @State private var showOnboarding: Bool = false
    
    @AppStorage("isOnboardingCompleted")
    private var isOnboardingCompleted: Bool = false

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs.indices, id: \.self) { index in
                NavigationStack {
                    tabs[index].view
                }
                .tabItem {
                    Image(
                        selectedTab == index
                        ? "\(tabs[index].iconName).selected"
                        : "\(tabs[index].iconName)"
                    )
                }
                .accessibilityLabel(tabs[index].title)
                .tag(index)
            }
        }
        .labelsHidden()
        .onAppear {
            if !isOnboardingCompleted {
                showOnboarding = true
            }
            #if DEBUG
            isOnboardingCompleted = false
            #endif
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(viewModel: OnboardingViewModel())
        }
        .onChange(of: isOnboardingCompleted) { isOnboardingCompleted in
            if isOnboardingCompleted {
                showOnboarding = false
            }
        }
    }
}

#Preview {
    TabBarView()
}
