//
//  ProductCell.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 21.03.2025.
//

import SwiftUI

struct ProductCell: View {
    private enum Drawing {
        static var spacing: CGFloat { 10 }
    }
    
    //MARK: - Properties
    let product: CartProduct
    let setQuantity: @Sendable (Int) -> Void
    
    //MARK: - init(_:)
    @inlinable
    init(
        _ product: CartProduct,
        setQuantity: @escaping @Sendable (Int) -> Void
    ) {
        self.product = product
        self.setQuantity = setQuantity
    }
    
    //MARK: - body
    var body: some View {
        HStack(spacing: Drawing.spacing) {
            WebImage(product.image)
                .equatable()
                .frame(maxWidth: 120)
            
            ProductDescription(
                product.title,
                price: product.price,
                quantity: Binding(
                    get: { product.quantity },
                    set: setQuantity
                )
            )
            .equatable()
        }
    }
}

extension ProductCell: Equatable {
    @inlinable
    nonisolated static func == (lhs: ProductCell, rhs: ProductCell) -> Bool {
        lhs.product == rhs.product
    }
}

#Preview {
    VStack {
        ForEach(CartProduct.sample) { p in
            ProductCell(p) { _ in }
        }
    }
}
