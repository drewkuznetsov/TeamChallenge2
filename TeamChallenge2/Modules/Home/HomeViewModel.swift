//
//  HomeViewModel.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 05.03.2025.
//

import Foundation
import ShoppeStore

final class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var state: LoadingState = .loading
    
    private let networkManager = ShoppeStore.shared
    
    func fetchProducts() async throws {
        do {
            products = try await networkManager.fetchAllProducts().get()
            state = .loaded
        } catch {
            state = .error
            }
    }
}
