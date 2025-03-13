//
//  HomeViewContent.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 09.03.2025.
//

import SwiftUI

struct HomeViewCollections: View {
    let categories: [Category]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 22) {
                HomeSection(
                    title: "Categories") {
                        CategoriesGrid(categories: categories)
                    } onTapSeeAll: {
                        // move to CategoriesView()
                    }
                
                HomeSection(title: "Popular") {
                    Populars(products: categories.first?.products ?? [])
                } onTapSeeAll: {
                    // move to PDP
                }

                HomeSection(title: "Just for You") {
                    JustForYouGrid(products: categories.first?.products ?? [])
                } onTapSeeAll: {
                    // move to PDP
                }

            }
        }
    }
}

#Preview {
    HomeViewCollections(categories: Array(repeating: Category.makeStubCategory(), count: 4))
}
