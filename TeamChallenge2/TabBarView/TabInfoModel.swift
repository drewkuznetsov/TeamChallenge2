//
//  TabInfo.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//

import SwiftUI

struct TabInfoModel {
    /// Title of the tab.
    let title: String
    /// Image name for the tab icon.
    let iconName: String
    /// The view that is displayed when the tab is selected.
    let view: AnyView
}

extension TabInfoModel {
    static var allCases: [TabInfoModel] = [
        TabInfoModel(title: "Home", iconName: "home", view: AnyView(Text("Home"))),
        TabInfoModel(title: "Wishlist", iconName: "wishlist", view: AnyView(Text("Wishlist"))),
        TabInfoModel(title: "Categories", iconName: "categories", view: AnyView(Text("Categories"))),
        TabInfoModel(title: "Cart", iconName: "cart", view: AnyView(Text("Cart"))),
        TabInfoModel(title: "Profile", iconName: "profile", view: AnyView(Text("Profile"))),
    ]
}
