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
        static var padding: CGFloat { 4 }
    }
    
    //MARK: - Properties
    let product: CartProduct
    let setQuantity: @MainActor (Int) -> Void
    let onDelete: () -> Void
    
    //MARK: - init(_:)
    @inlinable
    init(
        _ product: CartProduct,
        setQuantity: @escaping @MainActor (Int) -> Void,
        onDelete: @escaping () -> Void
    ) {
        self.product = product
        self.setQuantity = setQuantity
        self.onDelete = onDelete
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
                    set: { setQuantity($0) }
                )
            )
            .equatable()
        }
        .overlay(alignment: .bottomLeading) {
            ButtonIcon(.trashCircle, action: onDelete)
                .padding(Drawing.padding)
                .background(Color.white)
                .clipShape(Circle())
                .foregroundStyle(Color.red)
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
            ProductCell(p, setQuantity: { _ in }, onDelete: {})
                .frame(width: 335, height: 110)
        }
    }
}
