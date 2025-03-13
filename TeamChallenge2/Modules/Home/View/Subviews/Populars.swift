//
//  Populars.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 12.03.2025.
//

import SwiftUI

struct Populars: View {
    let products: [ProductBO]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -3) {
                ForEach(products, id: \.id) { product in
                    PopularCell(product: product)
                        .padding(6)
                }
            }
            .padding(.leading, 14)
        }
    }
}

#Preview {
    Populars(products: Array(
        repeating: ProductBO.makeStubProductBO(),
        count: 7)
             )
}
