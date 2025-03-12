//
//  JustForYouCell.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 12.03.2025.
//

import SwiftUI

struct JustForYouCell: View {
    let product: ProductBO
    let width: CGFloat
    let onAddToFavorites: (Int) -> Void
    let onAddToCart: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: product.image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(160.0 / 171.0, contentMode: .fit)
                    .frame(width: width)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 5))
            } placeholder: {
                ProgressView()
            }
            
            Spacer()
                .frame(height: 11)
            
            TitleAndPrice(title: product.title, price: product.price)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        onAddToFavorites(product.id)
                    } label: {
                        Image(product.isFavorite ? .heartFill : .heart)
                    }
                }
            
            Spacer()
                .frame(height: 8)
            
            Button {
                onAddToCart(product.id)
            } label: {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.blue)
                    .frame(height: 31)
                    .overlay {
                        Text("Add to cart")
                            .foregroundStyle(.white)
                            .font(.system(size: 12))
                    }
                    
            }


        }
    }
}

#Preview {
    JustForYouCell(product: ProductBO.makeStubProductBO(), width: 100) {
        print("Add to favorites \($0)")
    } onAddToCart: {
        print("Add to cart \($0)")
    }
}
