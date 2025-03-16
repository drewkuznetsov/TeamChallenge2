//
//  CartView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct CartView: View {
    let header: Header
    
    let changeAddress: () -> Void
    let checkout: () -> Void
    
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
            
            HStack(spacing: 10) {
                AsyncImage(
                    url: URL(string: "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg"),
                    content: { $0.resizable() },
                    placeholder: ProgressView.init
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 10, y: 5)
                .frame(maxWidth: 120, maxHeight: 100)
                VStack(alignment: .leading) {
                    Text("Lorem ipsum dolor sit amet consectetur.")
                        .font(.callout)
                    Text("Pink, Size M")
                    HStack {
                        
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            TotalBar(14, buttonTitle: "Checkout", checkout: checkout)
                .equatable()
        }
    }
}

extension CartView {
    struct Header: Equatable {
        let title: String
        let total: Int
        
        @inlinable init(_ title: String, total: Int) {
            self.title = title
            self.total = total
        }
    }
    
}

#Preview {
    NavigationStack {
        CartView(
            header: CartView.Header("Cart", total: 2),
            changeAddress: { print("changeAddress") },
            checkout: { print("checkout") }
        )
    }
}
