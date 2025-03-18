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
        (UIScreen.main.bounds.width - Constants.sideOffset * 2.0 - Constants.interItemSpacing) / 2.0
    }
    
    private var cellHeight: CGFloat {
        cellWidth + Constants.bottomInset
    }
    
    private var gridItems: [GridItem] {
        Array(repeating: GridItem(spacing: 10), count: 2)
    }
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 15) {
            ForEach(0..<categories.count) { index in
                let category = categories[index]
                CategoryCell(category: category)
                    .frame(width: cellWidth)
            }
        }
        .padding()
    }
}

extension CategoriesGrid {
    private enum Constants {
        static let sideOffset = 20.0
        static let interItemSpacing = 5.0
        static let bottomInset = 27.0
    }
}

#Preview {
    CategoriesGrid(categories: Array(repeating: Category.makeStubCategory(), count: 4))
}
