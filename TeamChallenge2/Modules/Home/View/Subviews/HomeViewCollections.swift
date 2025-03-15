//
//  HomeViewContent.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 09.03.2025.
//

import SwiftUI

struct HomeViewCollections: View {
    let categories: [Category]
    let onTapAllCategories: () -> Void
    let onTapPopular: () -> Void
    let onTapRecomendations: () -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 22) {
                HomeSection(title: Constants.categories) {
                        CategoriesGrid(categories: categories)
                    } onTapSeeAll: {
                        onTapAllCategories()
                    }
                
                HomeSection(title: Constants.popular) {
                    Populars(products: categories.first?.products ?? [])
                } onTapSeeAll: {
                    onTapPopular()
                }

                HomeSection(title: Constants.justForYou) {
                    JustForYouGrid(products: categories.first?.products ?? [])
                } onTapSeeAll: {
                    onTapRecomendations()
                }
            }
        }
    }
}

extension HomeViewCollections {
    private enum Constants {
        static let categories = "Categories"
        static let popular = "Popular"
        static let justForYou = "Just for You"
    }
}

#Preview {
    HomeViewCollections(
        categories: Array(repeating: Category.makeStubCategory(), count: 4)) {
            //
        } onTapPopular: {
            //
        } onTapRecomendations: {
            //
        }

}
