//
//  ProductBO.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 09.03.2025.
//

import Foundation
import ShoppeStore
import UIKit

struct ProductBO {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Product.Category
    let image: UIImage
    let rating: Product.Rating
    var isFavorite: Bool
    var isAddedToBasket: Bool
    
    init(id: Int,
         title: String,
         price: Double,
         description: String,
         category: Product.Category,
         image: UIImage,
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
    
//    init(product: Product) {
//        self.id = product.id
//        self.title = product.title
//        self.price = product.price
//        self.description = product.description
//        self.category = product.category
//        self.image = product.image
//        self.rating = product.rating
//        self.isFavorite = false
//        self.isAddedToBasket = false
//    }
    
    mutating func setFavorite(_ isFavortie: Bool) {
        self.isFavorite = isFavortie
    }
    
    mutating func addToBasket(_ isAdded: Bool) {
        self.isAddedToBasket = isAdded
    }
    
    static func makeStubProductBO() -> Self {
        let urlString = [
            "https://cort-inn.ru/upload/resize_cache/iblock/601/1920_1080_2/kl9pto7lsibo1172up7j81n4kvdx1nz3.jpg",
            "https://tophotels.ru/icache/hotel_photos/83/17/24898/2696110_740x550.jpg"
        ].randomElement() ?? ""
        
        let url = URL(string: urlString) ?? URL(fileURLWithPath: "")
        
        return ProductBO(
            id: Int.random(in: 0...100),
            title: "Some title",
            price: Double.random(in: 0...100),
            description: "Some description",
            category: Product.Category.allCases.randomElement() ?? .electronics,
            image: UIImage(),
            rating: Product.Rating(rate: Double.random(in: 0...5), count: Int.random(in: 0...5)),
            isFavorite: Bool.random(),
            isAddedToBasket: Bool.random()
        )
    }
}
