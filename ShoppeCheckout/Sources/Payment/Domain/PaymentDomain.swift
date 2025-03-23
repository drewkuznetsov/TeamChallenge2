//
//  PaymentDomain.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 22.03.2025.
//

import Foundation
import UDF

struct PaymentDomain: ReducerDomain {
    //MARK: - State
    struct State {
        
    }
    
    //MARK: - Action
    enum Action {
        
    }
    
    //MARK: - reducer
    @inlinable
    func reduce(_ state: inout State, action: Action) async -> any Effect {
        
        return empty
    }
}
