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
    
    @inlinable
    func withSize(_ equally: CGFloat) -> some View {
        withSize(CGSize(width: equally, height: equally))
    }
}
