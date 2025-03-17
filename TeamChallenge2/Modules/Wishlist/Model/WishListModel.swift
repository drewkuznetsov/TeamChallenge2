//
//  WishListModel.swift
//  TeamChallenge2
//
//  Created by Gerodot on 16.03.2025.
//

import Foundation
import ShoppeStore

struct WishListModel {
    let TitleLabel = "Wishlist"
    let storeName = "Shoppe"
    
    static var sample: [ProductBO] = Array(
        repeating: ProductBO.makeStubProductBO(),
        count: 6
    )
}
