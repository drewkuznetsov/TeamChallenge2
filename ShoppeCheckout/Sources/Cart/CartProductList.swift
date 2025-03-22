//
//  CartProductList.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 22.03.2025.
//

import SwiftUI

struct CartProductList<Cell: View>: View {
    //MARK: - Drawing
    private enum Drawing {
        static var cellHeightFraction: CGFloat { 0.25 }
    }

    //MARK: - Properties
    let products: [CartProduct]
    let cellProvider: (CartProduct, CGSize) -> Cell

    //MARK: - init(_:)
    @inlinable
    init(_ products: [CartProduct], cellProvider: @escaping (CartProduct, CGSize) -> Cell) {
        self.products = products
        self.cellProvider = cellProvider
    }
    
    //MARK: - body
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(products) { cellProvider($0, proxy.size) }
                }
            }
            .padding([.horizontal, .top])
        }
    }

}

//MARK: - Equatable
extension CartProductList: Equatable {
    @inlinable
    nonisolated static func == (lhs: CartProductList, rhs: CartProductList) -> Bool {
        lhs.products == rhs.products
    }
}

//MARK: - Preview
#Preview {
    CartProductList(CartProduct.sample) { product, _ in
        ProductCell(
            product,
            setQuantity: { _ in },
            onDelete: { }
        )
    }
}
