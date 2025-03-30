//
//  HomeViewModel.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 05.03.2025.
//

import Foundation
import ShoppeStore
import UIKit

final class HomeViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var state: LoadingState = .loading
    @Published var error: Error?
    @Published var isErrorShown = false
    @Published var productsInBasket = 2
    
    private let networkManager = ShoppeStore.shared
    private let imageLoader = ImageLoaderService()
//    private var imagesMap: [URL: UIImage] = [:]
    
    @MainActor
    func fetchProducts() async throws {
        do {
            async let allProducts = try await networkManager.fetchAllProducts().get()
            async let allCategories = try await networkManager.fetchAllCategories().get()
            let (products, categories) = try await (allProducts, allCategories)
            let imagesMap = try await fetchImages(for: allProducts)
            self.categories = makeCategories(from: products, categories: categories, imagesMap: imagesMap)
            state = .loaded
        } catch {
            self.error = error
            isErrorShown = true
        }
    }
    
    private func fetchImages(for products: [Product]) async -> [URL: UIImage] {
        let imagesUrls = products.map { $0.image }
        return await imageLoader.fetchImagesMap(for: imagesUrls)
    }
    
    private func makeCategories(from products: [Product], categories: [Product.Category], imagesMap: [URL: UIImage]) -> [Category] {
        categories.map { category in
            Category(
                name: category.rawValue.capitalized,
                products: products
                    .filter { $0.category == category }
                    .map { makeProductBO(from: $0, imagesMap: imagesMap) }
            )
        }
    }
    
    private func makeProductBO(from product: Product, imagesMap: [URL: UIImage]) -> ProductBO {
        ProductBO(
            id: product.id,
            title: product.title,
            price: product.price,
            description: product.description,
            category: product.category,
            image: imagesMap[product.image] ?? UIImage(),
            rating: product.rating,
            isFavorite: false,
            isAddedToBasket: false
        )
    }
}

