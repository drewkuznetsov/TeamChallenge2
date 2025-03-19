//
//  CartView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct CartView: View {
    let header: Header
    let products: [CartProduct]
    let changeAddress: () -> Void
    let checkout: () -> Void
    
    //MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
            CartHeader(header.title, quantity: header.total)
                .equatable()
                .padding(.horizontal)
            
            CheckoutInfo(
                "Shipping address",
                text: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
                changeTap: changeAddress
            )
            .equatable()
            .padding(.horizontal)
            
            ScrollView {
                ForEach(products) { product in
                    HStack(spacing: 10) {
                        
                        AsyncImage(
                            url: product.image,
                            content: { $0.resizable() },
                            placeholder: ProgressView.init
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 10, y: 5)
                        .frame(maxWidth: 120/*, maxHeight: 100*/)
                        
                        ProductDescription(
                            product.title,
                            price: product.price,
                            quantity: .constant(product.quantity)
                        )
                        .equatable()
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: 110)
                }
            }
            TotalBar(14, buttonTitle: "Checkout", checkout: checkout)
                .equatable()
        }
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
            checkout: { print("checkout") }
        )
    }
}
