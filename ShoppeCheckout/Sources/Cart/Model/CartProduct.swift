//
//  CartProduct.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 20.03.2025.
//

import Foundation
import ShoppeStore
import UDF

@dynamicMemberLookup
struct CartProduct: Equatable, Identifiable {
    let product: Product
    var quantity: Int
    
    var id: Identifier<Product, Int> {
        Identifier(rawValue: product.id)
    }
    
    init?(_ product: Product, quantity: Int) {
        if quantity < 1 { return nil }
        self.product = product
        self.quantity = quantity
    }
    
    @inlinable
    subscript<T>(dynamicMember keyPath: KeyPath<Product, T>) -> T {
        product[keyPath: keyPath]
    }
    
    static var sample: [CartProduct] {
        Product.sample.compactMap {
            CartProduct($0, quantity: Int.random(in: 1...10))
        }
    }
}

extension Product {
    static var sample: [Product] {
        [
            Product(
                id: 1,
                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                price: 109.95,
                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                category: .mensClothing,
                image: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!,
                rating: Product.Rating(rate: 3.9, count: 120)
            ),
            Product(
                id: 2,
                title: "Mens Casual Premium Slim Fit T-Shirts ",
                price: 22.3,
                description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                category: .mensClothing,
                image: URL(string: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg")!,
                rating: Product.Rating(rate: 4.1, count: 259)
            ),
            Product(
                id: 10,
                title: "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
                price: 109,
                description: "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)",
                category: .electronics,
                image: URL(string: "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg")!,
                rating: Product.Rating(rate: 2.9, count: 470)
            )
        ]
    }
}
