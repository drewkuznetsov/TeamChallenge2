//
//  CartDomainTest.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Testing
import Foundation
import ShoppeStore
@testable import Cart


struct CartDomainTest {
    func makeSut(
        fetchProducts: @escaping @Sendable () async -> Result<[Product], Error> = {
            Issue.record("Should't run")
            return .failure(URLError(.badURL))
        },
        loadCart: @escaping @Sendable () -> [Int: Int] = {
            Issue.record("Should't run")
            return [:]
        },
        fetchLocation: @escaping @Sendable () -> String? = {
            Issue.record("Should't run")
            return ""
        }
    ) -> CartDomain {
        CartDomain(
            .init(
                fetchProducts: fetchProducts,
                loadCart: loadCart,
                fetchLocation: fetchLocation
            )
        )
    }

    @Test func onViewAppear() async throws {
        let sut = makeSut()
        var state = CartDomain.State()
        let token = try #require(CartDomain.LoadToken.test)
        var actions = await Array(sut.reduce(&state, action: .onAppear))
        
        #expect(state.cart.isEmpty == true)
        #expect(state.products == nil)
        #expect(actions == [.fetchProducts(token), .loadCart])
        
        state = CartDomain.State(products: .loading)
        
        actions = await Array(sut.reduce(&state, action: .onAppear))
        
        #expect(actions == [.loadCart])
    }

    @Test func loadCart() async throws {
        let cart = [1: 1]
        let sut = makeSut(loadCart: { cart })
        
        var state = CartDomain.State()
        
        _ = await sut.reduce(&state, action: .loadCart)
        
        #expect(state.cart == cart)
    }
    
    @Test func fetchProducts() async throws {
        let sut = makeSut(fetchProducts: { .failure(URLError(.badURL)) })
        var state = CartDomain.State()
        
        _ = await sut.reduce(&state, action: .fetchProducts(.test))
        
        #expect(state.products == .loading)
    }
    
    @Test func fetchProductEndSuccess() async throws {
        let test = Product(
            id: 1,
            title: "baz",
            price: 1,
            description: "bar",
            category: .electronics,
            image: URL(string: "foo")!,
            rating: .init(rate: 1, count: 1)
        )
        
        let sut = makeSut()
        var state = CartDomain.State()
        
        _ = await sut.reduce(&state, action: .fetchProductResult(.success([test])))
        
        #expect(state.products == .loaded([test]))
    }
    
    @Test func fetchProductEndError() async throws {
        let error = URLError(.badURL)
        let sut = makeSut()
        var state = CartDomain.State()
        
        _ = await sut.reduce(&state, action: .fetchProductResult(.failure(error)))
        
        #expect(state.products == .failed(error))
    }
    
    @Test func removeProductFromCart() async throws {
        let sut = makeSut()
        var state = CartDomain.State(cart: [1:1])
        
        _ = await sut.reduce(&state, action: .removeProduct(1))
        
        #expect(state.cart.isEmpty == true)
    }
    
    @Test func changeProductCount() async throws {
        let sut = makeSut()
        var state = CartDomain.State(cart: [1:1])
        
        _ = await sut.reduce(&state, action: .setProduct(1, count: 2))
        
        #expect(state.cart == [1: 2])
        
        _ = await sut.reduce(&state, action: .setProduct(1, count: 1))
        
        #expect(state.cart == [1: 1])
        
        _ = await sut.reduce(&state, action: .setProduct(2, count: 1))
        
        #expect(state.cart == [1: 1])
        
        let actions = await Array(sut.reduce(&state, action: .setProduct(1, count: 0)))
        
        #expect(actions == [.removeProduct(1)])
    }
}
