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
    let header: CartHeader.DataSource
    let info: CheckoutInfo.DataSource
    let products: [CartProduct]
    let bottomBar: TotalBar.DataSource
    
    let setProductQuantity: @Sendable (CartProduct.ID, Int) -> Void
    let deleteProduct: (CartProduct.ID) -> Void
    
    //MARK: - init(_:)
    init(
        header: CartHeader.DataSource,
        info: CheckoutInfo.DataSource,
        products: [CartProduct],
        bottomBar: TotalBar.DataSource,
        setProductQuantity: @escaping @Sendable (CartProduct.ID, Int) -> Void,
        deleteProduct: @escaping (CartProduct.ID) -> Void
    ) {
        self.header = header
        self.info = info
        self.products = products
        self.bottomBar = bottomBar
        self.setProductQuantity = setProductQuantity
        self.deleteProduct = deleteProduct
    }
    
    //MARK: - body
    var body: some View {
        VStack(alignment: .leading, spacing: Drawing.verticalSpacing) {
            CartHeader(dataSource: header)
                .equatable()
                .padding(.horizontal)
            
            CheckoutInfo(dataSource: info)
                .equatable()
                .padding([.horizontal, .top])
            
            GeometryReader { proxy in
                ScrollView {
                    ForEach(products) { product in
                        ProductCell(
                            product,
                            setQuantity: { setProductQuantity(product.id, $0) },
                            onDelete: { deleteProduct(product.id) }
                        )
                        .equatable()
                        .frame(height: computeCellFraction(proxy))
                    }
                }
                .padding([.horizontal, .top])
            }
            TotalBar(dataSource: bottomBar)
                .equatable()
        }
    }
    
    private func computeCellFraction(_ proxy: GeometryProxy) -> CGFloat {
        ceil(proxy.size.height * Drawing.cellHeightFraction)
    }
}

//MARK: - Equatable
extension CartView: @preconcurrency Equatable {
    @inlinable
    static func == (lhs: CartView, rhs: CartView) -> Bool {
        lhs.header == rhs.header
        && lhs.products == rhs.products
        && lhs.info == rhs.info
        && lhs.bottomBar == rhs.bottomBar
    }
}

//MARK: - Preview
#Preview {
    NavigationStack {
        CartView(
            header: CartHeader.DataSource(
                "Cart",
                total: 2
            ),
            info: CheckoutInfo.DataSource(
                title: "Shipping address",
                text: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
                change: { print("Change info") }
            ),
            products: CartProduct.sample,
            bottomBar: TotalBar.DataSource(
                "Total",
                total: 14.95,
                button: "Checkout",
                onTap: { print("Checkout") }
            ),
            setProductQuantity: { print("Product: \($0), quantity: \($1.description)") },
            deleteProduct: { print("Delete product: \($0)") }
        )
    }
}
