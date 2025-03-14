//
//  TabInfo.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//

import SwiftUI

struct TabBarItem {
    /// Title of the tab.
    let title: String
    /// Image name for the tab icon.
    let iconName: String
    /// The view that is displayed when the tab is selected.
    let view: AnyView
}

extension TabBarItem {
    // Example of an array of views
    static var allCases: [TabBarItem] = [
        TabBarItem(title: "Home",       iconName: "home",       view: AnyView(HomeView())),
        TabBarItem(title: "Wishlist",   iconName: "wishlist",   view: AnyView(Text("Wishlist"))),
        TabBarItem(title: "Categories", iconName: "categories", view: AnyView(Text("Categories"))),
        TabBarItem(title: "Cart",       iconName: "cart",       view: AnyView(Text("Cart"))),
        TabBarItem(title: "Profile",    iconName: "profile",    view: AnyView(Text("Profile"))),
    ]
}
