//
//  PopularCell.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 12.03.2025.
//

import SwiftUI

struct PopularCell: View {
    let product: ProductBO
    
    let size:CGFloat = 130
    
    var body: some View {
        VStack(spacing: 1) {
            SquareAsyncImage(url: product.image, size: size)
                .padding(5)
                .background(.white)
                .clipShape(.rect(cornerRadius: 9))
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            Spacer()
                .frame(height: 4)
            TitleAndPrice(title: product.title, price: product.price)
        }
    }
}

#Preview {
    PopularCell(product: ProductBO.makeStubProductBO())
}
