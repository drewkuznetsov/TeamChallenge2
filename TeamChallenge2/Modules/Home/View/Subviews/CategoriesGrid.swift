//
//  CategoriesGrid.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 11.03.2025.
//

import SwiftUI

struct CategoriesGrid: View {
    let categories: [Category]
    
    private var cellWidth: CGFloat {
        (UIScreen.main.bounds.width - 20*2 - 5)/2
    }
    
    private var cellHeight: CGFloat {
        cellWidth + 27
    }
    
    private var gridItems: [GridItem] {
        Array(repeating: GridItem(spacing: 5), count: 2)
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(0..<categories.count) { index in
                let category = categories[index]
                CategoryCell(category: category)
                    .frame(width: cellWidth)
            }
        }
    }
}

#Preview {
    CategoriesGrid(categories: Array(repeating: Category.makeStubCategory(), count: 4))
}
