//
//  ReducerDomain.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation
import FoundationFX

public protocol ReducerDomain: Sendable {
    typealias Effect = Sequence<Action>
    associatedtype State
    associatedtype Action: Sendable
    
    func reduce(_ state: inout State, action: Action) async -> any Effect
}

public extension ReducerDomain {
    var empty: some Effect { EmptyCollection() }
    
    @inlinable
    func run(_ action: Action) -> some Effect {
        CollectionOfOne(action)
    }
    
    @inlinable
    func schedule(
        @Array<Action>.Builder _ block: () -> [Action]
    ) -> some Effect {
        block()
    }
}
