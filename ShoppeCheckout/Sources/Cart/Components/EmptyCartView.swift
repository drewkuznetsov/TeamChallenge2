//
//  EmptyCartView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 22.03.2025.
//

import SwiftUI

struct EmptyCartView: View, Equatable {
    let reason: String
    let buttonTitle: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Label(reason, systemImage: "cart")
                .font(.title3)
                .foregroundStyle(Color.gray.opacity(0.5))
            Button(buttonTitle, action: action)
                .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
    
    @inlinable
    nonisolated static func == (lhs: EmptyCartView, rhs: EmptyCartView) -> Bool {
        lhs.reason == rhs.reason && lhs.buttonTitle == rhs.buttonTitle
    }
}

#Preview {
    EmptyCartView(
        reason: "No goods here...",
        buttonTitle: "Tap me sempai!",
        action: { print("I've been tapped!") }
    )
}
