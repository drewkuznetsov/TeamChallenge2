//
//  ProductCardView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 17.03.2025.
//


import SwiftUI
import ShoppeStore

struct ProductCardView: View {
    @State var productToView: ProductBO
    var size: CGFloat
    var state: LoadingState
    var alignment: Alignment = .top
    var scaleType: ContentMode = .fill
    var actionAddToFavorites: () -> Void
    var actionAddToCart: () -> Void
    
    private var isButtonsDisabled: Bool { state == .loading }
    
    var body: some View {
        VStack{
            SquareAsyncImage(
                url: productToView.image,
                size: size,
                alignment: .center,
                scaleType: scaleType
            )
            .padding(5)
            .background(.white)
            .clipShape(.rect(cornerRadius: 11))
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            HStack {
                VStack(alignment:.leading) {
                    Text(productToView.title)
                        .font(.bodyRegular)
                        .lineLimit(2)
                        .frame(minHeight: 30)
                    Text(productToView.price.formatted(.currency(code: "USD")))
                        .font(.bodyBold)
                    
                    Button {
                        productToView.isAddedToBasket.toggle()
                    } label:  {
                        Text(
                            productToView.isAddedToBasket
                            ? "Remove from Cart"
                            : "Add to Cart"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .font(.secondaryActionText)
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .clipShape(.rect(cornerRadius: 5))
                    .disabled(isButtonsDisabled)
                }
                
                VStack {
                    Spacer()
                    Button {
                        productToView.isFavorite.toggle()
                    } label: {
                        Image(
                            productToView.isFavorite
                            ? .heart
                            : .heartFill
                        )
                        .padding(5)
                    }
                    .disabled(isButtonsDisabled)
                }
            }
            .padding(5)
        }
    }
}

#Preview {
    let prod: ProductBO = ProductBO.makeStubProductBO()
    ProductCardView(
        productToView: prod,
        size: 300,
        state: .loaded,
        actionAddToFavorites: { WishlistViewModel().addToFavorites(id: prod.id) },
        actionAddToCart: { WishlistViewModel().addToCart(id: prod.id) }
    )
}
