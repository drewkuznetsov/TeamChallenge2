//
//  WishlistView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 15.03.2025.
//

import SwiftUI
import ShoppeStore

struct WishlistView: View {
    @StateObject var viewModel = WishlistViewModel()
    let model = WishListModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private var cellWidth: CGFloat {
        (UIScreen.main.bounds.width - Constants.sideInset * 2.0 - Constants.interItemSpacing * 2.0 ) / 2.0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: Constants.interItemSpacing) {
                    ForEach(viewModel.favoriteProducts, id: \.id) { product in
                        ProductCardView(
                            productToView: product,
                            size: cellWidth,
                            state: viewModel.state,
                            scaleType: viewModel.scaleType,
                            actionAddToFavorites: { viewModel.addToFavorites(id: product.id) },
                            actionAddToCart: { viewModel.addToCart(id: product.id) }
                        )
                    }
                }
                .padding(Constants.interItemSpacing)
                .modifier(ShimmerEffect(loadingState: viewModel.state))
            }
        }
        .refreshable {
            Task { await viewModel.fetchFavoriteProducts() }
        }
        .navigationTitle(model.titleLabel)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing:Constants.interItemSpacing){
                    Text(model.titleLabel).font(.sectionHeader)
                    TextField(model.search, text: $viewModel.searchText)
                        .padding(.horizontal, Constants.interItemSpacing)
                        .padding(.vertical, 5)
                        .background(.ultraThinMaterial)
                        .clipShape(.capsule)
                }
            }
        }
    }
}


extension WishlistView {
    private enum Constants {
        static let sideInset = 20.0
        static let interItemSpacing = 15.0
    }
}

#Preview {
    WishlistView()
}
