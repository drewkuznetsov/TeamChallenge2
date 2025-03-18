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
        GridItem(.flexible()), // Первая колонка
        GridItem(.flexible())  // Вторая колонка
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
                            actionAddToFavorites: { viewModel.addToFavorited(id: product.id) },
                            actionAddToCart: { viewModel.addToCart(id: product.id) }
                        )
                    }
                }
                .padding(Constants.interItemSpacing)
                .modifier(ShimmerEffect(loadingState: viewModel.state))
            }
        }
        .onAppear {
            Task { await viewModel.fetchFavoriteProducts() }
        }
        .refreshable {
            Task { await viewModel.fetchFavoriteProducts() }
        }
        .navigationTitle(model.TitleLabel)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing:Constants.interItemSpacing){
                    Text(model.TitleLabel).font(.sectionHeader)
                    TextField("Search", text: $viewModel.searchText)
                        .padding(.horizontal, Constants.interItemSpacing)
                        .padding(.vertical)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: Constants.interItemSpacing))
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





