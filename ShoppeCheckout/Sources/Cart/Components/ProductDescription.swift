//
//  ProductDescription.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 20.03.2025.
//

import SwiftUI

struct ProductDescription: View {
    private let description: String
    private let price: Double
    @Binding private var quantity: Int
    
    //MARK: - init(_:)
    init(_ description: String, price: Double, quantity: Binding<Int>) {
        self.description = description
        self.price = price
        self._quantity = quantity
    }
    
    //MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
                .font(.callout)
            Spacer()
            HStack {
                Text("$".appending(price.description))
                    .font(.title2.bold())
                Spacer()
                QuantityStepper($quantity)
            }
        }
    }
    
}

//MARK: - Equatable
extension ProductDescription: @preconcurrency Equatable {
    @inlinable
    static func == (lhs: ProductDescription, rhs: ProductDescription) -> Bool {
        lhs.description == rhs.description
        && lhs.price == rhs.price
        && lhs.quantity == rhs.quantity
    }
}

//MARK: - Preview
#Preview {
    ProductDescription(
        "Lorem ipsum dolor sit amet consectetur.",
        price: 7,
        quantity: .constant(20)
    )
    .frame(maxWidth: 200, maxHeight: 120)
}
