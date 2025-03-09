//
//  ProductBO.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 09.03.2025.
//

import Foundation
import ShoppeStore

struct ProductBO {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: URL
    let rating: Product.Rating
    var isFavorite: Bool
    var isAddedToBasket: Bool
    
    init(id: Int,
         title: String,
         price: Double,
         description: String,
         category: String,
         image: URL,
         rating: Product.Rating,
         isFavorite: Bool,
         isAddedToBasket: Bool
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
        self.isFavorite = isFavorite
        self.isAddedToBasket = isAddedToBasket
    }
    
    init(product: Product) {
        self.id = product.id
        self.title = product.title
        self.price = product.price
        self.description = product.description
        self.category = product.category
        self.image = product.image
        self.rating = product.rating
        self.isFavorite = false
        self.isAddedToBasket = false
    }
    
    mutating func setFavorite(_ isFavortie: Bool) {
        self.isFavorite = isFavortie
    }
    
    mutating func addToBasket(_ isAdded: Bool) {
        self.isAddedToBasket = isAdded
    }
}
