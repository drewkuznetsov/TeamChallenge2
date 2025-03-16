//
//  WishListViewModel.swift
//  TeamChallenge2
//
//  Created by Gerodot on 15.03.2025.
//

import SwiftUI
import ShoppeStore
class WishlistViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var state: LoadingState = .loading
    @Published var error: Error?
    @Published var isErrorShown = false
    @Published var productsInBasket = 2
    @Published var favoriteProducts: [Product] = []
    @Published var favoriteProductsIds: Set<Int>?
    @Published var searchText = "" {
        didSet { self.filterProducts() }
    }
    
    private var allFavoriteProducts: [Product] = []
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
            
            await MainActor.run {
                self.products = fetchedProducts
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
        do {
            #if DEBUG
            if networkManager.persistence.favorites != nil {
                networkManager.persistence.favorites = [1, 2, 3, 20]
            }
            #endif
            
            let favoriteProductsIds = self.networkManager.persistence.favorites ?? []
            
            var fetchedProducts: [Product] = []
            await withTaskGroup(of: Product?.self) { group in
                for id in favoriteProductsIds {
                    group.addTask {
                        return try? await self.networkManager.fetchProduct(withId: id).get()
                    }
                }
                for await product in group {
                    if let product = product {
                        fetchedProducts.append(product)
                    }
                }
            }
            
            await MainActor.run {
                self.allFavoriteProducts = fetchedProducts
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
    
    private func filterProducts() {
        if searchText.isEmpty {
            favoriteProducts = allFavoriteProducts
        } else {
            favoriteProducts = allFavoriteProducts.filter { product in
                product.title.lowercased().contains(searchText.lowercased()) ||
                product.description.lowercased().contains(searchText.lowercased()) ||
                product.category.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    public func addToCart(_ id: Int) {
        networkManager.persistence.favorites?.insert(id)
    }
    
    public func addToFavorited(_ id: Int) {
        networkManager.persistence.favorites?.insert(id)
    }
}
