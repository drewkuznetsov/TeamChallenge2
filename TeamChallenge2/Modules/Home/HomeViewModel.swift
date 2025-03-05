//
//  HomeViewModel.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 05.03.2025.
//

import Foundation
import ShoppeStore
import SwiftFP

struct Category {
    let title: String
    let products: [Product]
    
    init(title: String, products: [Product]) {
        self.title = title
        self.products = products
    }
    
    init(_ category: Product.Category, from products: [Product]) {
        self.init(
            title: category.rawValue.capitalized,
            products: products.filter(\.category == category)
        )
    }
}

typealias Categories = Array<Category>

extension Categories {
    init(_ cat: [Product.Category], products: [Product]) {
        self = cat.map { category -> Category in
            Category(category, from: products)
        }
    }
}

final class HomeViewModel: ObservableObject {
    @Published var state: LoadingState = .loading
    @Published var category: Product.Category = .mensClothing
    
    private let networkManager = ShoppeStore.shared
    
    @Sendable
    func onAppear() async {
        self.state = await zip(
            networkManager.fetchAllCategories(),
            networkManager.fetchAllProducts()
        )
        .map(Categories.init)
        .map(LoadingState.loaded)
        .either()
        .mapRight(LoadingState.error)
        .unwrap
    }
    
//    func fetchProducts() async throws {
//        do {
//            products = try await networkManager.fetchAllProducts().get()
//            state = .loaded
//        } catch {
//            state = .error
//            }
//    }
}
