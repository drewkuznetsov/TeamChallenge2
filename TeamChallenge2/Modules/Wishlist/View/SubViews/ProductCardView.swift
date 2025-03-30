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
    var actionAddToFavorites: () -> Void
    var actionAddToCart: () -> Void
    
    var body: some View {
        VStack{
            SquareImage(image: productToView.image, size: size, alignment: .center, scaleType: .fit)
                .padding(5)
                .background(.white)
                .clipShape(.rect(cornerRadius: 9))
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
                            ? "In Cart"
                            : "Add to Cart"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .font(.secondaryActionText)
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .clipShape(.rect(cornerRadius: 5)
                    )
                }
                
                VStack {
                    Spacer()
                    Button {
                        productToView.isFavorite.toggle()
                    } label: {
                        Image(productToView.isFavorite ? .heart : .heartFill)
                            .padding(5)
                    }
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
        actionAddToFavorites: { WishlistViewModel().addToFavorited(id: prod.id) },
        actionAddToCart: { WishlistViewModel().addToCart(id: prod.id) }
    )
}
