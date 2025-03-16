//
//  TabInfo.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//

import SwiftUI

struct AnyTabView: View {
    private let _body: AnyView
    
    init<V: View>(_ view: V) {
        _body = AnyView(view)
    }
    
    var body: some View {
        _body
    }
}

struct TabBarItem {
    let title: String
    let iconName: String
    let view: AnyTabView
}

extension TabBarItem {
    static var allCases: [TabBarItem] = [
        TabBarItem(
            title: "Home",
            iconName: "home",
            view: AnyTabView(HomeView())
        ),
        TabBarItem(
            title: "Wishlist",
            iconName: "wishlist",
            view: AnyTabView(Text("Wishlist"))
        ),
        TabBarItem(
            title: "Categories",
            iconName: "categories",
            view: AnyTabView(Text("Categories"))
        ),
        TabBarItem(
            title: "Cart",
            iconName: "cart",
            view: AnyTabView(Text("Cart"))
        ),
        TabBarItem(
            title: "Profile",
            iconName: "profile",
            view: AnyTabView(
                Button("Logout") {
                    RootViewModel.shared.logout()
                }
            )
        )
    ]
}
