//
//  ProductView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 16.03.2025.
//

import SwiftUI
import ShoppeStore

struct ProductView: View {
    let product: Product
    var size: CGFloat
    
    var body: some View {
        VStack{
            SquareAsyncImage(url: product.image, size: 200)
            Text(product.title)
            Text(product.description)
            Text("\(product.price) €")
            Image(product.isFavorite ? .heart : .heartFill)
        }
            
    }
}

#Preview {
    let product = WishListModel.sample.first!
}
