//
//  ButtonIcon.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 20.03.2025.
//

import SwiftUI

struct ButtonIcon: View, Equatable {
    let icon: IconSymbol
    let size: CGFloat
    let action: () -> Void
    
    @inlinable
    init(
        _ icon: IconSymbol,
        size: CGFloat = 30,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon.rawValue)
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
    }
}

#Preview {
    VStack(spacing: 5) {
        ButtonIcon(.minusCircle, action: {})
        ButtonIcon(.plusCircle, action: {})
    }
}
