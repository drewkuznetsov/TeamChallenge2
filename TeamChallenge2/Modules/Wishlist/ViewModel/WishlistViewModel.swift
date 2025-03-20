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
    
    // MARK: - Published Properties
    @Published var products: [ProductBO] = []
    @Published var productsInCart: [Int : Int] = [:]
    @Published var favoriteProducts: [ProductBO] = []
    @Published var favoriteProductsIds: Set<Int> = []
    @Published var state: LoadingState = .loading {
        didSet { updateScaleType() }
    }
    @Published var scaleType: ContentMode = .fill
    @Published var error: Error?
    @Published var isErrorShown = false
    @Published var productsInBasket = 0
    @Published var searchText = "" {
        didSet { filterProducts() }
    }
    
    // MARK: - Private Properties
    private var allFavoriteProducts: [ProductBO] = []
    private let networkManager = ShoppeStore.shared
    
    // MARK: - Initialization
    init() {
        self.products = generateSkeletonData()
        self.favoriteProducts = generateSkeletonData()
        self.state = .loading
        
        Task {
            await fetchProducts()
            await fetchCartProducts()
            await fetchFavoriteProducts()
        }
    }
    
    // MARK: - Public Methods
    
    // MARK: Data Fetching
    func fetchProducts() async {
        await updateState(.loading)
        
        do {
            let fetchedProducts = try await networkManager.fetchAllProducts().get()
            let mappedProducts = mapProductsToBusinessObjects(fetchedProducts)
            
            await updateState(.loaded, products: mappedProducts)
        } catch {
            await handleError(error)
        }
    }
    
    func fetchFavoriteProducts() async {
        await updateState(.loading)
        
        #if DEBUG
        await generateMockFavoritesIfNeeded()
        await addDelay()
        #endif
        
        let favoriteIDs = networkManager.persistence.favorites ?? []
        let fetchedProducts = await fetchFavoriteProducts(ids: Array(favoriteIDs))
        
        await MainActor.run {
            allFavoriteProducts = fetchedProducts
            filterProducts()
            state = .loaded
        }
    }
    
    // MARK: Cart Operations
    func fetchCartProducts() async {
        await updateState(.loading)
        
        #if DEBUG
        generateMockCartIfNeeded()
        #endif
        
        guard let cart = networkManager.persistence.card else { return }
        #if DEBUG
        dump(cart)
        #endif
        
        await MainActor.run {
            self.productsInCart = cart
        }
    }
    
    func addToCart(id: Int) {
        networkManager.persistence.card = productsInCart
    }
    
    // MARK: Favorites Management
    func addToFavorites(id: Int) {
        networkManager.persistence.favorites?.insert(id)
        if let product = products.first(where: { $0.id == id }) {
            allFavoriteProducts.append(product)
            filterProducts()
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: State Management
    private func updateState(_ newState: LoadingState, products: [ProductBO] = []) async {
        await MainActor.run {
            state = newState
            if newState == .loading {
                self.products = generateSkeletonData()
                self.favoriteProducts = generateSkeletonData()
            } else if !products.isEmpty {
                self.products = products
            }
        }
    }
    
    private func handleError(_ error: Error) async {
        await MainActor.run {
            self.error = error
            isErrorShown = true
            state = .loaded
        }
    }
    
    // MARK: UI Helpers
    private func updateScaleType() {
        scaleType = state == .loading ? .fill : .fit
    }
    
    private func generateSkeletonData() -> [ProductBO] {
        let skeletonData = (0..<10).map { _ in ProductBO.makeLocalStubLocalProductBO() }
        return skeletonData
    }
    
    // MARK: Data Processing
    private func mapProductsToBusinessObjects(_ products: [Product]) -> [ProductBO] {
        products.map(ProductBO.init)
    }
    
    private func filterProducts() {
        if searchText.isEmpty {
            favoriteProducts = allFavoriteProducts
        } else {
            let searchLowercased = searchText.lowercased()
            favoriteProducts = allFavoriteProducts.filter {
                $0.title.lowercased().contains(searchLowercased) ||
                $0.description.lowercased().contains(searchLowercased) ||
                $0.category.rawValue.lowercased().contains(searchLowercased)
            }
        }
    }
    
    // MARK: Mock Data Generation (Debug Only)
    #if DEBUG
    private func generateMockFavoritesIfNeeded() async {
        guard networkManager.persistence.favorites == nil else { return }
        
        var uniqueIDs = Set<Int>()
        while uniqueIDs.count < 10 {
            uniqueIDs.insert(Int.random(in: 1...20))
        }
        
        networkManager.persistence.favorites = uniqueIDs
    }
    
    private func generateMockCartIfNeeded() {
        if networkManager.persistence.card == nil {
            networkManager.persistence.card = [1: 1, 2: 2]
        }
    }
    #endif
    
    // MARK: Network Operations
    private func fetchFavoriteProducts(ids: [Int]) async -> [ProductBO] {
        await withTaskGroup(of: ProductBO?.self) { group in
            for id in ids {
                group.addTask {
                    guard let product = try? await self.networkManager.fetchProduct(withId: id).get() else {
                        return nil
                    }
                    return ProductBO(product: product)
                }
            }
            
            var results = [ProductBO]()
            for await case let product? in group {
                results.append(product)
            }
            return results
        }
    }
    
    private func addDelay() async {
        try? await Task.sleep(for: .seconds(3), tolerance: .seconds(1))
    }
}
