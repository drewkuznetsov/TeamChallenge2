//
//  ButtonIcon.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 20.03.2025.
//

import SwiftUI

struct ButtonIcon: View, Equatable {
    let icon: String
    let size: CGFloat
    let action: () -> Void
    
    @inlinable
    init(
        systemName: String,
        size: CGFloat = 30,
        action: @escaping () -> Void
    ) {
        self.icon = systemName
        self.size = size
        self.action = action
    }
    
    @inlinable
    init(
        _ icon: IconSymbol,
        size: CGFloat = 30,
        action: @escaping () -> Void
    ) {
        self.icon = icon.rawValue
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
        }
        .withSize(size)
    }
    
    @inlinable
    nonisolated static func == (lhs: ButtonIcon, rhs: ButtonIcon) -> Bool {
        lhs.icon == rhs.icon
        && lhs.size == rhs.size
    }
}

extension ButtonIcon {
    enum IconSymbol: String {
        case minusCircle = "minus.circle"
        case plusCircle = "plus.circle"
        case trashCircle = "trash.circle"
    }
}

#Preview {
    VStack(spacing: 5) {
        ButtonIcon(.minusCircle, action: {})
        ButtonIcon(.plusCircle, action: {})
    }
}
