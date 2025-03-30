//
//  JustForYouCell.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 12.03.2025.
//

import SwiftUI

struct JustForYouCell: View {
    let product: ProductBO
    let size: CGFloat
    let onAddToFavoritesAction: (Int) -> Void
    let onAddToCartAction: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            SquareImage(image: product.image, size: size)
            
            Spacer()
                .frame(height: 11)
            
            TitleAndPrice(title: product.title, price: product.price)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        onAddToFavoritesAction(product.id)
                    } label: {
                        Image(product.isFavorite ? .heartFill : .heart)
                    }
                }
            
            Spacer()
                .frame(height: 8)
            
            Button {
                onAddToCartAction(product.id)
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.accentColor)
                    .frame(height: 31)
                    .overlay {
                        Text(Constants.addToCart)
                            .foregroundStyle(.white)
                            .font(.secondaryActionText)
                    }
                    
            }


        }
    }
}

extension JustForYouCell {
    private enum Constants {
        static let addToCart = "Add to cart"
    }
}

#Preview {
    JustForYouCell(product: ProductBO.makeStubProductBO(), size: 100) {
        print("Add to favorites \($0)")
    } onAddToCartAction: {
        print("Add to cart \($0)")
    }
}
