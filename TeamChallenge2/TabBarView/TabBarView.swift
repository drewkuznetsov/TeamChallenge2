//
//  TabBarView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 11.03.2025.
//

import SwiftUI




struct TabBarView: View {
    /// Selected tab. Initialized to 0 to highlight the first tab at the start.
    @State private var selectedTab: Int = 0
    var tabs: [TabInfoModel]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs.indices, id: \.self) { index in
                NavigationStack {
                    AnyView(tabs[index].view) // Явное преобразование
                }
                .tabItem {
                    Image(selectedTab == index ? "\(tabs[index].iconName).selected" : tabs[index].iconName)
                }
                .accessibilityLabel(tabs[index].title)
                .tag(index)
            }
        }
        .labelsHidden()
    }
}

#Preview {
    TabBarView(tabs: TabInfoModel.allCases)
}
