//
//  ReducerDomain.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation

public protocol ReducerDomain<State, Action>: Sendable {
    associatedtype State
    associatedtype Action: Sendable
    
    func reduce(_ state: inout State, action: Action) async -> Action?
}
