//
//  Category.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 09.03.2025.
//

import ShoppeStore

struct Category {
    let name: String
    let products: [ProductBO]
    
    static func makeStubCategory() -> Self {
        let name = "\(Product.Category.allCases.randomElement()?.rawValue ?? "")".capitalized
        return Category(
            name: name,
            products: Array(
                repeating: ProductBO.makeStubProductBO(),
                count: Int.random(in: 1...4)
            )
        )
    }
}
