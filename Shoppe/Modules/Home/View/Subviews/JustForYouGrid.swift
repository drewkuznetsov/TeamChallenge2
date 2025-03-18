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
        (UIScreen.main.bounds.width - Constants.sideInset * 2.0 - Constants.interItemSpacing) / 2.0
    }
    
    private var gridItems: [GridItem] {
        let gridItem = GridItem(spacing: Constants.interItemSpacing)
        return [gridItem, gridItem]
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: Constants.interItemSpacing) {
            ForEach(0..<products.count) { index in
                let product = products[index]
                JustForYouCell(product: product, size: cellWidth, onAddToFavoritesAction: { _ in
                    
                }, onAddToCartAction: { _ in
                })
                    .frame(width: cellWidth)
            }
        }
        .padding(Constants.sideInset)
    }
}

extension JustForYouGrid {
    private enum Constants {
        static let sideInset = 20.0
        static let interItemSpacing = 13.0
    }
}
#Preview {
    JustForYouGrid(products: Array(repeating: ProductBO.makeStubProductBO(), count: 4))
}
