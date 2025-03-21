//
//  CartView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct CartView: View {
    //MARK: - Drawing
    private enum Drawing {
        static var verticalSpacing: CGFloat { .zero }
        static var cellHeightFraction: CGFloat { 0.25 }
    }
    
    //MARK: - Properties
    let header: Header
    let products: [CartProduct]
    let changeAddress: () -> Void
    let checkout: () -> Void
    let setProductQuantity: @Sendable (CartProduct.ID, Int) -> Void
    
    //MARK: - body
    var body: some View {
        VStack(alignment: .leading, spacing: Drawing.verticalSpacing) {
            CartHeader(header.title, quantity: header.total)
                .equatable()
                .padding(.horizontal)
            
            CheckoutInfo(
                "Shipping address",
                text: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
                changeTap: changeAddress
            )
            .equatable()
            .padding([.horizontal, .top])
            GeometryReader { proxy in
                ScrollView {
                    ForEach(products) { product in
                        ProductCell(product) {
                            setProductQuantity(product.id, $0)
                        }
                        .equatable()
                        .frame(height: computeCellFraction(proxy))
                    }
                }
                .padding([.horizontal, .top])
            }
            TotalBar(14, buttonTitle: "Checkout", checkout: checkout)
                .equatable()
        }
    }
    
    private func computeCellFraction(_ proxy: GeometryProxy) -> CGFloat {
        ceil(proxy.size.height * Drawing.cellHeightFraction)
    }
}

extension CartView {
    //MARK: - Header
    struct Header: Equatable {
        let title: String
        let total: Int
        
        @inlinable init(_ title: String, total: Int) {
            self.title = title
            self.total = total
        }
    }
    
}

//MARK: - Preview
#Preview {
    NavigationStack {
        CartView(
            header: CartView.Header("Cart", total: 2),
            products: CartProduct.sample,
            changeAddress: { print("changeAddress") },
            checkout: { print("checkout") },
            setProductQuantity: { print("Product: \($0), quantity: \($1.description)") }
        )
    }
}
