//
//  CartView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            Text("Hello world!")
        }
//        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Cart")
    }
}

#Preview {
    NavigationStack {
        CartView()
    }
}
