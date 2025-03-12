//
//  TabBarView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//

import SwiftUI

struct TabBarView: View {
    var tabs: [TabBarItem]
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs.indices, id: \.self) { index in
                NavigationStack {
                    AnyView(tabs[index].view)
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
    }
}

#Preview {
    TabBarView(tabs: TabBarItem.allCases)
}
