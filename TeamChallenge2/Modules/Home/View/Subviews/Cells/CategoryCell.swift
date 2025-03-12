//
//  CategoryCell.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 11.03.2025.
//

import SwiftUI

struct CategoryCell: View {
    let category: Category
//    let imagesURL: [String]
    
    private var maxAmount: Int {
        min(4, imagesURL.count)
    }
    
    private var size: CGFloat {
        ((UIScreen.main.bounds.width / 2.0) - 20 - 2 - 6*2 - 4) / 2
    }
    
    private var gridItems: [GridItem] {
        let gridItem = GridItem(.fixed(size), spacing: 4)
        return imagesURL.count > 2 ? [gridItem, gridItem] : [gridItem]
    }
    
    private var imagesURL: [URL] {
        category.products.map { $0.image }
    }
    
    var body: some View {
        VStack(spacing: 6) {
            grid
            HStack {
                Text(category.name)
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                badge
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 9)
                .fill(.white)
                .shadow(radius: 10, x: 0, y: 5)
        )
    }
    
    private var grid: some View {
        LazyHGrid(rows: gridItems, spacing: 4) {
            ForEach(0..<maxAmount) { index in
                let url = imagesURL[index]
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: size, height: size)
                .clipShape(.rect(cornerRadius: 5))
            }
        }
        .frame(height: size * 2 + 4)
    }
    
    private var badge: some View {
        Text(category.products.count.formatted())
            .font(.system(size: 12, weight: .bold))
            .padding(.horizontal, 8)
            .background(
                Color.blue
                    .clipShape(.rect(cornerRadius: 6))
            )
    }
}

#Preview {
    CategoryCell(category: Category.makeStubCategory())
    .frame(width: 200)
}
