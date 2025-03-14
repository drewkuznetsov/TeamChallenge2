//
//  CartItemView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct CartItemView: View {
    let path: String
    @Binding var count: Int
    let delete: () -> Void
    
    var body: some View {
        HStack {
            AsyncProductImage(path)
                .equatable()
                .overlay(alignment: .bottomLeading) {
                    IconButton(.trash) { }
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .frame(width: 120, height: 100)
            VStack {
                Text("Some long text long long long text")
                    .font(.body)
                
                Text("Some description")
                    .font(.title3)
                
                HStack {
                    Text(17.00, format: .currency(code: "USD"))
                    
                    CounterView($count)
                }
            }
        }
    }
}

#Preview {
    CartItemView(
        path: "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
        count: .constant(3),
        delete: { }
    )
}
