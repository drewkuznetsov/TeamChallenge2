//
//  CartDomain.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation
import FoundationFX

public struct CartDomain: ReducerDomain {
    //MARK: - State
    public struct State: Equatable {
        
    }
    
    //MARK: - Action
    public enum Action: Sendable {
        
    }
    
    //MARK: - Reducer
    @inlinable
    public func reduce(_ state: inout State, action: Action) async -> Action? {
        
        return nil
    }
}
