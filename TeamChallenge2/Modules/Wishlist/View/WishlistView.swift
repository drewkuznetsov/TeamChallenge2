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
                            actionAddToFavorites: { viewModel.addToFavorited(id: product.id) },
                            actionAddToCart: { viewModel.addToCart(id: product.id) }
                        )
                    }
                }
                .padding(Constants.interItemSpacing)
                .modifier(Shimmer(loadingState: viewModel.state))
            }
        }
        .onAppear {
            Task { await viewModel.fetchFavoriteProducts() }
        }
        .navigationTitle(model.TitleLabel)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing:20){
                    Text(model.TitleLabel).font(.sectionHeader)
                    TextField("Search", text: $viewModel.searchText)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 20))
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

public struct Shimmer: ViewModifier {
    
    var loadingState: LoadingState = .loading
    @State var isInitialState: Bool = true
    
    public func body(content: Content) -> some View {
        switch loadingState {
        case .loading:
            content
                .mask {
                    LinearGradient(
                        gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                        startPoint: (isInitialState ? .init(x: -5, y: -5) : .init(x: 1, y: 1)),
                        endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 5, y: 5))
                    )
                }
                .animation(
                    .linear(duration: 1.5).delay(0.5).repeatForever(autoreverses: false),
                    value: isInitialState
                )
                .onAppear() {
                    isInitialState = false
                }
                .redacted(reason: .placeholder)
        case .loaded:
            content
            
        }
    }
}

#Preview {
    WishlistView()
}





