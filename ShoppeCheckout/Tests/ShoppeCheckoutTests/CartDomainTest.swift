//
//  CartDomainTest.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Testing
import Foundation
import ShoppeStore
import UDF
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
        Product(
            id: 1,
            title: "baz",
            price: 1,
            description: "bar",
            category: .electronics,
            image: URL(string: "foo")!,
            rating: .init(rate: 1, count: 1)
        ),
        quantity: 1
    )!
        
    @Test func onViewAppear() async throws {
        let sut = makeSut()
        var state = Sut.State()
        
        let token = try #require(Sut.LoadContentToken.parse(state))
        var actions = await Array(sut.reduce(&state, action: .onAppear))
        
        #expect(actions == [.loadContent(token)])
        
        state = Sut.State(products: .success([product]), shippingAddress: "baz")
        
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
        
        #expect(state.products == .failure(.loading(error.localizedDescription)))
    }
    
    @Test func fetchProductEndSuccess() async throws {
        
        let cart = [1: 1]
        var sut = makeSut()
        var state = CartDomain.State()
        let token = try #require(Sut.LoadContentToken.parse(state))
        
        sut.dependency.fetchProducts = { .success([product.product]) }
        sut.dependency.fetchCart = { cart }
        _ = await sut.reduce(&state, action: .loadContent(token))
        
        #expect(state.products == .success([product]))
    }
    
    @Test func removeProductFromCart() async throws {
        let sut = makeSut()
        var state = CartDomain.State(products: .success([product]))
        
        _ = await sut.reduce(&state, action: .removeProduct(Identifier(rawValue: 1)))
        
        switch state.products {
        case .success(let content):
            #expect(content.isEmpty == true)
            
        case .failure, .none:
            throw NSError(domain: "Test", code: 1)
        }
    }
    
    @Test func changeProductCount() async throws {
        let sut = makeSut()
        var state = CartDomain.State(products: .success([product]))
        
        _ = await sut.reduce(&state, action: .setProduct(Identifier(rawValue: 1), count: 2))
        
        switch state.products {
        case .success(let content):
            #expect(content[0].quantity == 2)
            
        case .failure, .none:
            throw NSError(domain: "Test", code: 1)
        }
        
        _ = await sut.reduce(&state, action: .setProduct(Identifier(rawValue: 1), count: 1))
        
        switch state.products {
        case .success(let content):
            #expect(content[0].quantity == 1)
            
        case .failure, .none:
            throw NSError(domain: "Test", code: 1)
        }
        
        _ = await sut.reduce(&state, action: .setProduct(Identifier(rawValue: 2), count: 1))
        
        switch state.products {
        case .success(let content):
            #expect(content[0].quantity == 1)
            #expect(content.count == 1)
            
        case .failure, .none:
            throw NSError(domain: "Test", code: 1)
        }
        
        let actions = await Array(sut.reduce(&state, action: .setProduct(Identifier(rawValue: 1), count: 0)))
        
        #expect(actions == [.removeProduct(Identifier(rawValue: 1))])
    }
}
