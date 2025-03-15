//
//  HomeView.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 05.03.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        mainView
            .onAppear {
                Task { try await viewModel.fetchProducts() }
            }
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded:
            NavigationStack{
                HomeViewCollections(
                    categories: Array(repeating: Category.makeStubCategory(), count: 4)
                ) {
                    //
                } onTapPopular: {
                    //
                } onTapRecomendations: {
                    //
                }
                .padding(.zero)
                
                .safeAreaInset(edge: .top) {
                    VStack {
                        footer
                        Spacer()
                            .frame(height: 10)
                        search
                        Spacer()
                            .frame(height: 14)
                    }
                    .background(Color(uiColor: .systemBackground).opacity(0.6))
                    .background(.ultraThinMaterial)
                }
            }
        }
    }
    
    private var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 1) {
                Text(Constants.deliveryAdress)
                    .font(.microText)
                    .foregroundStyle(.gray)
                
                Button {
                    // open navigation
                } label: {
                    HStack(spacing: 5) {
                        Text(Constants.location)
                            .font(.statusText)
                            .foregroundStyle(.black)
                        Image(.arrowDown)
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                }
            }
            Spacer()
            Image(.basket)
                .resizable()
                .frame(width: 31, height: 28)
                .overlay(alignment: .topTrailing) {
                    if viewModel.productsInBasket > 0 {
                        Badge(amount: viewModel.productsInBasket)
                            .offset(x: 0, y: -2)
                    }
                    
                }
        }
        .padding(.horizontal, 20)
    }
    
    private var search: some View {
        HStack {
            Text(Constants.shop)
                .font(.sectionHeader)
            Button {
                // open search screen
            } label: {
                Capsule()
                    .fill(.ultraThinMaterial)
                    .frame(height: 36)
                    .overlay(alignment: .leading) {
                        Text(Constants.search)
                            .font(.searchText)
                            .foregroundStyle(.gray)
                            .padding(EdgeInsets(top: 9, leading: 16, bottom: 6, trailing: 0))
                    }
            }
            
        }
        .padding(.horizontal, 20)
    }
}

extension HomeView {
    private enum Constants {
        static let search = "Search"
        static let shop = "Shop"
        static let location = "Salatiga City, Central Java"
        static let deliveryAdress = "Delivery address"
    }
}

#Preview {
    HomeView()
}
