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
            VStack(spacing: 0) {
                footer
                Spacer()
                    .frame(height: 10)
                search
                Spacer()
                    .frame(height: 14)
                HomeViewCollections()
            }
            .padding(20)
        }
    }
    
    private var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 1) {
                Text("Delivery address")
                    .foregroundStyle(.gray)
                
                Button {
                    // open navigation
                } label: {
                    HStack(spacing: 5) {
                        Text("Salatiga City, Central Java")
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
    }
    
    private var search: some View {
        HStack {
            Text("Shop")
                .font(.system(size: 28, weight: .bold))
            Button {
                // open search screen
            } label: {
                Capsule()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 36)
                    .overlay(alignment: .leading) {
                        Text("Search")
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(.gray)
                            .padding(EdgeInsets(top: 9, leading: 16, bottom: 6, trailing: 0))
                    }
            }

        }
    }
}

#Preview {
    HomeView()
}
