//
//  Identifier.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 15.03.2025.
//

import Foundation

@dynamicMemberLookup
public struct Identifier<Domain, RawValue>: RawRepresentable {
    public let rawValue: RawValue
    
    @inlinable
    public init(rawValue: RawValue) { self.rawValue = rawValue }
    
    @inlinable
    public subscript<T>(dynamicMember keyPath: KeyPath<RawValue, T>) -> T {
        rawValue[keyPath: keyPath]
    }
    
}

public extension Identifier {
    
    @inlinable
    func coerced<NewDomain>(_ type: NewDomain.Type) -> Identifier<NewDomain, RawValue> {
        unsafeBitCast(self, to: Identifier<NewDomain, RawValue>.self)
    }
    
    @inlinable
    func map<T>(
        _ transform: (RawValue) throws -> T
    ) rethrows -> Identifier<Domain, T> {
        try Identifier<Domain, T>(rawValue: transform(self.rawValue))
    }
    
}

extension Identifier: Equatable where RawValue: Equatable {}
extension Identifier: Hashable where RawValue: Hashable {}
extension Identifier: Sendable where RawValue: Sendable {}
