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
    let products: Result<[CartProduct], CartError>?
    let bottomBar: TotalBar.DataSource
    
    let setProductQuantity: @MainActor (CartProduct.ID, Int) -> Void
    let deleteProduct: (CartProduct.ID) -> Void
    let goHomeTap: () -> Void
    
    //MARK: - init(_:)
    init(
        header: CartHeader.DataSource,
        info: CheckoutInfo.DataSource,
        products: Result<[CartProduct], CartError>?,
        bottomBar: TotalBar.DataSource,
        setProductQuantity: @escaping @MainActor (CartProduct.ID, Int) -> Void,
        deleteProduct: @escaping (CartProduct.ID) -> Void,
        goHomeTap: @escaping () -> Void
    ) {
        self.header = header
        self.info = info
        self.products = products
        self.bottomBar = bottomBar
        self.setProductQuantity = setProductQuantity
        self.deleteProduct = deleteProduct
        self.goHomeTap = goHomeTap
    }
    
    //MARK: - body
    var body: some View {
        VStack(spacing: Drawing.verticalSpacing) {
            CartHeader(dataSource: header)
                .equatable()
                .padding(.horizontal)
            
            CheckoutInfo(dataSource: info)
                .equatable()
                .padding([.horizontal, .top])
            
            switch products {
            case .none:
                CartProductList(CartProduct.sample) { product, area in
                    ProductCell(product)
                        .frame(height: computeCellFraction(area))
                }
                .redacted(reason: .placeholder)
                
            case .success(let content):
                CartProductList(content) { product, area in
                    ProductCell(
                        product,
                        setQuantity: { setProductQuantity(product.id, $0) },
                        onDelete: { deleteProduct(product.id) }
                    )
                    .equatable()
                    .frame(height: computeCellFraction(area))
                }
                .equatable()
                
            case .failure(let reason):
                EmptyCartView(
                    reason: reason.description,
                    buttonTitle: "Go shopping!",
                    action: goHomeTap
                )
                .equatable()
            }
            
            TotalBar(dataSource: bottomBar)
                .equatable()
        }
    }
    
    private func computeCellFraction(_ area: CGSize) -> CGFloat {
        ceil(area.height * Drawing.cellHeightFraction)
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
#Preview("Loaded") {
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
            products: .success(CartProduct.sample),
            bottomBar: TotalBar.DataSource(
                "Total",
                total: 14.95,
                button: "Checkout",
                onTap: { print("Checkout") }
            ),
            setProductQuantity: { print("Product: \($0), quantity: \($1.description)") },
            deleteProduct: { print("Delete product: \($0)") },
            goHomeTap: { print("open home page") }
        )
    }
}

#Preview("Loading") {
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
            products: nil,
            bottomBar: TotalBar.DataSource(
                "Total",
                total: 14.95,
                button: "Checkout",
                onTap: { print("Checkout") }
            ),
            setProductQuantity: { print("Product: \($0), quantity: \($1.description)") },
            deleteProduct: { print("Delete product: \($0)") },
            goHomeTap: { print("open home page") }
        )
    }
}

#Preview("Error") {
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
            products: .failure(.empty),
            bottomBar: TotalBar.DataSource(
                "Total",
                total: 14.95,
                button: "Checkout",
                onTap: { print("Checkout") }
            ),
            setProductQuantity: { print("Product: \($0), quantity: \($1.description)") },
            deleteProduct: { print("Delete product: \($0)") },
            goHomeTap: { print("open home page") }
        )
    }
}
