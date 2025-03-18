//
//  TitleAndPrice.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 12.03.2025.
//

import SwiftUI

struct TitleAndPrice: View {
    let title: String
    let price: Double
    
    var body: some View {
        VStack(spacing: 1) {
            
            Text(title)
                .font(.bodyRegular)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
            
            Text(price.formatted(.currency(code: "USD")))
                .font(.bodyBold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    TitleAndPrice(title: "Title", price: 20.93)
}
