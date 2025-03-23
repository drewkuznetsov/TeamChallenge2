//
//  CartDomain.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation
import SwiftFP
import ShoppeStore
import UDF

struct CartDomain: ReducerDomain {
    //MARK: - State
    struct State: Equatable {
        fileprivate(set) var products: Result<[CartProduct], CartError>?
        fileprivate(set) var shippingAddress: String
        
        var totalProducts: Int {
            switch products {
            case .success(let success): return success.count
            case .failure, .none: return .zero
            }
        }
        
        var totalPrice: Double {
            switch products {
            case .success(let items):
                return items
                    .map { $0.price * Double($0.quantity) }
                    .reduce(Double.zero, +)
                
            case .failure, .none: return .zero
            }
        }
        
        //MARK: - init(_:)
        init(
            products: Result<[CartProduct], CartError>? = nil,
            shippingAddress: String = .init()
        ) {
            self.products = products
            self.shippingAddress = shippingAddress
        }
    }
    
    //MARK: - Action
    enum Action: Sendable {
        case onAppear
        case loadContent(LoadContentToken)
        case fetchLocation
        case setProduct(_ id: CartProduct.ID, count: Int)
        case removeProduct(_ id: CartProduct.ID)
    }
        
    @inlinable
    init(_ dependencies: Dependency) { self.dependency = dependencies }
    
    //MARK: - Dependencies
    var dependency: Dependency
    
    //MARK: - Reducer
    @inlinable
    func reduce(_ state: inout State, action: Action) async -> any Self.Effect {
        switch action {
        case .onAppear:
            let action = LoadContentToken
                .parse(state)
                .map(Action.loadContent)
                .map(self.run(_:))
            
            guard let action else { break }
            return action
            
        case .loadContent:
            guard let cart = dependency.fetchCart() else {
                break
            }
            state.products = await dependency
                .fetchProducts()
                .mapError(CartError.init)
                .flatMap(reduceToCart(cart))
        
        case .fetchLocation:
            break
            
        case let .setProduct(id, quantity):
            guard case var .success(products) = state.products else {
                break
            }
            if quantity < 1 {
                return run(.removeProduct(id))
            }
            products.firstIndex(where: \.id == id).map { i in
                products[i].quantity = quantity
            }
            state.products = .success(products)
            
        case let .removeProduct(id):
            guard case var .success(products) = state.products else {
                break
            }
            products.removeAll(where: \.id == id)
            state.products = .success(products)
            
        }
        return empty
    }
    
    private func reduceToCart(_ cart: [Int: Int]) -> ([Product]) -> Result<[CartProduct], CartError> {
        { products in
            let cartProducts = products
                .compactMap { p -> (Product, Int)? in
                    Optional(p).zip(cart[p.id])
                }
                .compactMap(CartProduct.init)
            
            return cartProducts.isEmpty
            ? .failure(.empty)
            : .success(cartProducts)
        }
    }
 }

extension CartDomain {
    //MARK: - Dependency
    struct Dependency: Sendable {
        var fetchProducts: @Sendable () async -> Result<[Product], Error>
        var fetchCart: @Sendable () -> [Int: Int]?
        var fetchLocation: @Sendable () async -> String?
        
        public init(
            fetchProducts: @escaping @Sendable () async -> Result<[Product], Error>,
            fetchCart: @escaping @Sendable () -> [Int : Int]?,
            fetchLocation: @escaping @Sendable () async -> String?
        ) {
            self.fetchProducts = fetchProducts
            self.fetchCart = fetchCart
            self.fetchLocation = fetchLocation
        }
    }

    struct LoadContentToken {
        private init() {}

        @inlinable
        static func parse(_ state: State) -> LoadContentToken? {
            guard case .success = state.products else {
                return LoadContentToken()
            }
            if state.shippingAddress.isEmpty {
                return LoadContentToken()
            }
            return nil
        }
    }
}

extension CartDomain.Action: Equatable {
    @inlinable
    static func == (lhs: Self, rhs: Self) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}

extension CartDomain.Dependency {
    static var live: Self {
        let shoppe = ShoppeStore.shared
        return CartDomain.Dependency(
            fetchProducts: shoppe.fetchAllProducts,
            fetchCart: { shoppe.persistence.card },
            fetchLocation: { nil }
        )
    }
}
