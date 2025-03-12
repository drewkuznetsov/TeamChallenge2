//
//  CategoriesGrid.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 11.03.2025.
//

import SwiftUI

struct CategoriesGrid: View {
    let categories: [Category]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CategoriesGrid(categories: Array(repeating: Category.makeStubCategory(), count: 4))
}
