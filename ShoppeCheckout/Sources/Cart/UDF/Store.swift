//
//  Store.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation

@dynamicMemberLookup
public final class Store<Reducer: ReducerDomain>: ObservableObject, @unchecked Sendable {
    @usableFromInline let reducer: Reducer
    
    @Published public private(set) var state: Reducer.State
    
    //MARK: - init(_:)
    public init(reducer: Reducer, state: Reducer.State) {
        self.reducer = reducer
        self.state = state
    }
    
    public func send(_ action: Reducer.Action) {
        Task { @MainActor in
            await reducer.reduce(&state, action: action)
                .map(self.send(_:))
        }
    }
    
    //MARK: - Subscript
    @inlinable
    public subscript<T>(dynamicMember keyPath: KeyPath<Reducer.State, T>) -> T {
        state[keyPath: keyPath]
    }
}
