//
//  RequestState.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 15.03.2025.
//

import Foundation

enum RequestState<Success, Failure>: Equatable where Success: Equatable {
    case loading
    case loaded(Success)
    case failed(Failure)

    @inlinable
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
            
        case let (.loaded(l1), .loaded(l2)):
            return l1 == l2
            
        case let (.failed(f1),.failed(f2)):
            return String(describing: f1) == String(describing: f2)
            
        default: return false
        }
    }
}
