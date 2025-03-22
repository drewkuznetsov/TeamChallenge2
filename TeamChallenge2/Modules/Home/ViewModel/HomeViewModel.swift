//
//  HomeViewModel.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 05.03.2025.
//

import Foundation
import ShoppeStore

final class HomeViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var state: LoadingState = .loading
    @Published var error: Error?
    @Published var isErrorShown = false
    @Published var productsInBasket = 2
    
    private let networkManager = ShoppeStore.shared
    
    @MainActor
    func fetchProducts() async throws {
        do {
            async let allProducts = try await networkManager.fetchAllProducts().get()
            async let allCategories = try await networkManager.fetchAllCategories().get()
            let (products, categories) = try await (allProducts, allCategories)
            self.categories = makeCategories(from: products, categories: categories)
            state = .loaded
        } catch {
            self.error = error
            isErrorShown = true
        }
    }
    
    private func makeCategories(from products: [Product], categories: [Product.Category]) -> [Category] {
        categories.map { category in
            Category(
                name: category.rawValue.capitalized,
                products: products
                    .filter { $0.category == category }
                    .map { ProductBO(product: $0) }
            )
        }
    }
}

