//
//  CartContentView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 22.03.2025.
//

import SwiftUI
import UDF

public struct CartContentView: View {
    @StateObject private var store = Store(
        reducer: CartDomain(.live),
        state: CartDomain.State()
    )
    let goHome: () -> Void
    
    public init(
        goHome: @escaping () -> Void
    ) {
        self.goHome = goHome
    }
    
    public var body: some View {
        CartView(
            header: CartHeader.DataSource(
                "Cart",
                total: store.totalProducts
            ),
            info: CheckoutInfo.DataSource(
                title: "Shipping Address",
                text: store.shippingAddress,
                change: { store.send(.fetchLocation) }
            ),
            products: store.products,
            bottomBar: TotalBar.DataSource(
                "Total",
                total: store.totalPrice,
                button: "Checkout",
                onTap: {
                    #warning("Добавить навигацию на чекаут")
                }
            ),
            setProductQuantity: { store.send(.setProduct($0, count: $1)) },
            deleteProduct: { store.send(.removeProduct($0)) },
            goHomeTap: goHome
        )
        .equatable()
    }
}

#Preview {
    CartContentView(goHome: { })
}
