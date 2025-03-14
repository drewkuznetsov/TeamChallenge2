//
//  IconButton.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct IconButton: View, Equatable {
    let icon: Icon
    let action: () -> Void
    
    init(_ icon: Icon, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon.rawValue)
                .font(.title)
        }
        .frame(width: 30, height: 30)
    }
    
    @inlinable
    nonisolated static func == (lhs: IconButton, rhs: IconButton) -> Bool {
        lhs.icon == rhs.icon
    }
    
    enum Icon: String {
        case plusCircle = "plus.circle"
        case minusCircle = "minus.circle"
        case trash
    }
}



#Preview {
    VStack(spacing: 10) {
        IconButton(.plusCircle, action: {})
        IconButton(.minusCircle, action: {})
    }
}
