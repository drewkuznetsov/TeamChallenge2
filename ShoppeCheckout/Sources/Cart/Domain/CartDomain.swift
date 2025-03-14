//
//  CartDomain.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation
import FoundationFX
import ShoppeStore

struct CartDomain: ReducerDomain {
    //MARK: - State
    struct State: Equatable {
        fileprivate(set) var products: RequestState<[Product], Error>?
        fileprivate(set) var cart: [Int: Int]
        fileprivate(set) var shippingAddress: String?
        
        var totalProducts: Int { cart.count }
        
        var totalPrice: Double {
            guard case let .loaded(products) = products else {
                return .zero
            }
            return products
                .reduce(into: [Int: Double]()) { $0[$1.id] = $1.price }
                .merging(
                    cart.mapValues(Double.init),
                    uniquingKeysWith: *
                )
                .values
                .reduce(Double(), +)
        }
        
        //MARK: - init(_:)
        init(
            products: RequestState<[Product], Error>? = nil,
            cart: [Int: Int] = .init(),
            shippingAddress: String? = nil
        ) {
            self.products = products
            self.cart = cart
            self.shippingAddress = shippingAddress
        }
    }
    
    //MARK: - Action
    enum Action: Sendable, Equatable {
        case onAppear
        case loadCart
        case fetchProducts(CartDomain.LoadToken)
        case fetchLocation
        case fetchProductResult(Result<[Product], Error>)
        case setProduct(_ id: Int, count: Int)
        case removeProduct(_ id: Int)
        
        @inlinable
        static func == (lhs: Self, rhs: Self) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    struct Dependency: Sendable {
        let fetchProducts: @Sendable () async -> Result<[Product], Error>
        let loadCart: @Sendable () -> [Int: Int]
        let fetchLocation: @Sendable () async -> String?
    }
    
    init(_ dependencies: Dependency) {
        self.dependency = dependencies
    }
    
    //MARK: - Dependencies
    private let dependency: Dependency
    
    //MARK: - Reducer
    @inlinable
    func reduce(_ state: inout State, action: Action) async -> any Effect {
        switch action {
        case .onAppear:
            return schedule {
                if let token = LoadToken(state) {
                    Action.fetchProducts(token)
                }
                Action.fetchLocation
                Action.loadCart
            }
        case .loadCart:
            state.cart = dependency.loadCart()
            
        case .fetchProducts:
            state.products = .loading
            let result = await dependency.fetchProducts()
            return run(.fetchProductResult(result))
            
        case .fetchLocation:
            break
            
        case let .fetchProductResult(.success(products)):
            state.products = .loaded(products)
            
        case let .fetchProductResult(.failure(error)):
            state.products = .failed(error)
            
        case let .setProduct(id, count):
            guard state.cart.keys.contains(id) else {
                break
            }
            if count <= .zero {
                return run(.removeProduct(id))
            }
            state.cart.updateValue(count, forKey: id)
            
        case let .removeProduct(id):
            state.cart.removeValue(forKey: id)
        }
        return empty
    }
}

extension CartDomain {
    //MARK: - LoadToken
    struct LoadToken: Equatable {
        init?(_ state: State) {
            switch state.products {
            case .none, .loaded: return
            default: return nil
            }
        }
        
        private init() {}
        static let test = LoadToken()
    }
}
