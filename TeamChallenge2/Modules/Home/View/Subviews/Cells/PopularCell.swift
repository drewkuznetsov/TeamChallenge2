//
//  PopularCell.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 12.03.2025.
//

import SwiftUI

struct PopularCell: View {
    
    let product: ProductBO
    
    var body: some View {
        VStack(spacing: 1) {
            image
            Spacer()
                .frame(height: 4)
            TitleAndPrice(title: product.title, price: product.price)
        }
        .frame(width: 140)
    }
    
    private var image: some View {
        AsyncImage(url: product.image) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 130)
        } placeholder: {
            ProgressView()
        }
        .clipShape(.rect(cornerRadius: 5))
        .padding(5)
        .background {
            Color.white
                .clipShape(.rect(cornerRadius: 9))
                .shadow(radius: 10, y: 5)
        }
        
    }
}

#Preview {
    PopularCell(product: ProductBO.makeStubProductBO())
}
