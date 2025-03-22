//
//  CartError.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 20.03.2025.
//

import Foundation

enum CartError: Error, Equatable, CustomStringConvertible {
    case loading(String)
    case empty
    
    init(_ error: Error) {
        self = .loading(error.localizedDescription)
    }
    
    var description: String {
        switch self {
        case .loading(let reason): return reason
        case .empty: return "Cart is empty..."
        }
    }
}
