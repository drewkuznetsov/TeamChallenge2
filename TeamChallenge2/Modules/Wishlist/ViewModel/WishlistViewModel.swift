//
//  WishListViewModel.swift
//  TeamChallenge2
//
//  Created by Gerodot on 15.03.2025.
//

import SwiftUI
import ShoppeStore
import Foundation

class WishlistViewModel: ObservableObject {
    @Published var products: [ProductBO] = []
    @Published var state: LoadingState = .loading
    @Published var error: Error?
    @Published var isErrorShown = false
    @Published var productsInBasket = 2
    @Published var favoriteProducts: [ProductBO] = Array( repeating: ProductBO.makeStubProductBO(), count: 4 )
    @Published var favoriteProductsIds: Set<Int>?
    @Published var searchText = "" {
        didSet { self.filterProducts() }
    }

    private var allFavoriteProducts: [ProductBO] = []
    {
        didSet {
            self.filterProducts()
            print(self.allFavoriteProducts)
        }
    }
    private let networkManager = ShoppeStore.shared

    func fetchProducts() async {
        await MainActor.run { self.state = .loading }
        do {
            let fetchedProducts = try await Task {
                try await self.networkManager.fetchAllProducts().get()
            }.value

            let productBOs: [ProductBO] = []
//            fetchedProducts.map { product in
//                ProductBO(product: product)
//            }

            await MainActor.run {
                self.products = productBOs
                self.state = .loaded
            }
        } catch {
            await MainActor.run {
                self.error = error as NSError
                self.isErrorShown = true
                self.state = .loaded
            }
        }
    }

    func fetchFavoriteProducts() async {
        await MainActor.run { self.state = .loading }

        #if DEBUG
        
        do {
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000) // 3 секунды
        } catch {
            print("Задержка была прервана: \(error)")
        }

        if networkManager.persistence.favorites != nil {
            var randomDigits = Set<Int>()
            
            for _ in 0..<10 {
                var randomNumber = Int.random(in: 1...20)
                while randomDigits.contains(randomNumber) {
                    randomNumber = Int.random(in: 1...20)
                }
                randomDigits.insert(randomNumber)
            }
            
            networkManager.persistence.favorites = randomDigits
        }

        #endif

        let favoriteProductsIds = self.networkManager.persistence.favorites ?? []

        var fetchedProducts: [ProductBO] = []

        await withTaskGroup(of: Product?.self) { group in
            for id in favoriteProductsIds {
                group.addTask {
                    return try? await self.networkManager.fetchProduct(withId: id).get()
                }
            }

            for await product in group {
                if let product = product {
//                    fetchedProducts.append(ProductBO(product: product))
                }
            }
        }

        self.allFavoriteProducts = fetchedProducts

        await MainActor.run {
            self.state = .loaded
        }

    }

    private func filterProducts() {
        favoriteProducts = searchText.isEmpty
        ? allFavoriteProducts
        : allFavoriteProducts.filter { self.productMatchesSearchText(product: $0) }
    }

    private func productMatchesSearchText(product: ProductBO) -> Bool {
        let lowercasedSearchText = searchText.lowercased()
        return
        product.title.lowercased().contains(lowercasedSearchText) ||
        product.description.lowercased().contains(lowercasedSearchText) ||
        product.category.rawValue.lowercased().contains(lowercasedSearchText)
    }

    public func fetchCartProducts() async {
        await MainActor.run { self.state = .loading }

        #if DEBUG

        if networkManager.persistence.card != nil {
            networkManager.persistence.card = [1: 1, 2: 2]
        }

        #endif
    }

    public func addToCart(id: Int) {
        networkManager.persistence.card = [id : 1]
    }

    public func addToFavorited(id: Int) {
        networkManager.persistence.favorites?.insert(id)
        favoriteProducts.append(contentsOf: products.filter { $0.id == id })
    }
}
