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

extension CartDomain.Dependency {
    static let test = CartDomain.Dependency(
        fetchProducts: {
            Issue.record("Should't run")
            return .failure(URLError(.badURL))
        },
        fetchCart: {
            Issue.record("Should't run")
            return [:]
        },
        fetchLocation: {
            Issue.record("Should't run")
            return ""
        }
    )
}

struct CartDomainTest {
    typealias Sut = CartDomain
    func makeSut(_ d: Sut.Dependency = .test) -> Sut {
        Sut(d)
    }
    
    let product = CartProduct(
        product: Product(
            id: 1,
            title: "baz",
            price: 1,
            description: "bar",
            category: .electronics,
            image: URL(string: "foo")!,
            rating: .init(rate: 1, count: 1)
        ),
        quantity: 1
    )
        
    @Test func onViewAppear() async throws {
        let sut = makeSut()
        var state = Sut.State()
        
        let token = try #require(Sut.LoadContentToken.parse(state))
        var actions = await Array(sut.reduce(&state, action: .onAppear))
        
        #expect(actions == [.loadContent(token)])
        
        state = Sut.State(products: [product], shippingAddress: "baz")
        
        actions = await Array(sut.reduce(&state, action: .onAppear))
        
        #expect(actions.isEmpty == true)
    }

    @Test func loadContentFailed() async throws {
        var sut = makeSut()
        var state = CartDomain.State()
        let token = try #require(Sut.LoadContentToken.parse(state))
        let error = URLError(.badURL)
        
        sut.dependency.fetchProducts = { .failure(URLError(.badURL)) }
        sut.dependency.fetchCart = { [1: 1] }
        _ = await Array(sut.reduce(&state, action: .loadContent(token)))
        
        #expect(state.error == .loading(error.localizedDescription))
    }
    
    @Test func fetchProductEndSuccess() async throws {
        
        let cart = [1: 1]
        var sut = makeSut()
        var state = CartDomain.State()
        let token = try #require(Sut.LoadContentToken.parse(state))
        
        sut.dependency.fetchProducts = { .success([product.product]) }
        sut.dependency.fetchCart = { cart }
        _ = await sut.reduce(&state, action: .loadContent(token))
        
        #expect(state.products == [product])
    }
    
    @Test func removeProductFromCart() async throws {
        let sut = makeSut()
        var state = CartDomain.State(products: [product])
        
        _ = await sut.reduce(&state, action: .removeProduct(1))
        
        #expect(state.products.isEmpty == true)
    }
    
    @Test func changeProductCount() async throws {
        let sut = makeSut()
        var state = CartDomain.State(products: [product])
        
        _ = await sut.reduce(&state, action: .setProduct(1, count: 2))
        
        #expect(state.products[0].quantity == 2)
        
        _ = await sut.reduce(&state, action: .setProduct(1, count: 1))
        
        #expect(state.products[0].quantity == 1)
        
        _ = await sut.reduce(&state, action: .setProduct(2, count: 1))
        
        #expect(state.products[0].quantity == 1)
        #expect(state.products.count == 1)
        
        let actions = await Array(sut.reduce(&state, action: .setProduct(1, count: 0)))
        
        #expect(actions == [.removeProduct(1)])
    }
}
