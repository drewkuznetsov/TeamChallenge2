//
//  JustForYouGrid.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 12.03.2025.
//

import SwiftUI

struct JustForYouGrid: View {
    let products: [ProductBO]
    
    private var cellWidth: CGFloat {
        (UIScreen.main.bounds.width - 20*2 - 13)/2
    }
    
    private var gridItems: [GridItem] {
        let gridItem = GridItem(spacing: 13)
        return [gridItem, gridItem]
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 13) {
            ForEach(0..<products.count) { index in
                let product = products[index]
                JustForYouCell(product: product, width: cellWidth, onAddToFavorites: { _ in
                    
                }, onAddToCart: { _ in
                })
                    .frame(width: cellWidth)
            }
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    JustForYouGrid(products: Array(repeating: ProductBO.makeStubProductBO(), count: 4))
}
