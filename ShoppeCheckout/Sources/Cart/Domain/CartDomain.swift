//
//  CartDomain.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation
import SwiftFP
import ShoppeStore

struct CartDomain: ReducerDomain {
    //MARK: - State
    struct State: Equatable {
        fileprivate(set) var products: [CartProduct]
        fileprivate(set) var shippingAddress: String
        fileprivate(set) var error: CartError?
        
        var totalProducts: Int { products.count }
        
        var totalPrice: Double {
            products
                .map { $0.price * Double($0.quantity) }
                .reduce(Double.zero, +)
        }
        
        //MARK: - init(_:)
        init(
            products: [CartProduct] = .init(),
            shippingAddress: String = .init(),
            error: CartError? = nil
        ) {
            self.products = products
            self.shippingAddress = shippingAddress
            self.error = error
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
            switch await dependency.fetchProducts() {
            case .success(let products):
                let cart = dependency.fetchCart()
                state.products = products
                    .compactMap { p -> (Product, Int)? in
                        Optional(p)
                            .zip(cart[p.id])
                    }
                    .compactMap(CartProduct.init)
                
            case .failure(let e):
                state.error = CartError.loading(e.localizedDescription)
            }
            
        case .fetchLocation:
            break
            
        case let .setProduct(id, quantity):
            if quantity < 1 {
                return run(.removeProduct(id))
            }
            state.products.firstIndex(where: \.id == id).map { i in
                state.products[i].quantity = quantity
            }
            
        case let .removeProduct(id):
            state.products.removeAll(where: \.id == id)
            
        }
        return empty
    }
}

extension CartDomain {
    //MARK: - Dependency
    struct Dependency: Sendable {
        var fetchProducts: @Sendable () async -> Result<[Product], Error>
        var fetchCart: @Sendable () -> [Int: Int]
        var fetchLocation: @Sendable () async -> String?
        
        public init(
            fetchProducts: @escaping @Sendable () -> Result<[Product], Error>,
            fetchCart: @escaping @Sendable () -> [Int : Int],
            fetchLocation: @escaping @Sendable () -> String?
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
            if state.shippingAddress.isEmpty || state.products.isEmpty {
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
