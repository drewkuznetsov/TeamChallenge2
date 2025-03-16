//
//  View+.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 16.03.2025.
//

import SwiftUI

extension View {
    @inlinable
    func withSize(_ s: CGSize) -> some View {
        frame(width: s.width, height: s.height)
    }
}
