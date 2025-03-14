//
//  AsyncProductImage.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct AsyncProductImage: View, Equatable {
    //MARK: - Drawing
    private enum Drawing {
        @inlinable static var equalsRatio: CGFloat { 1 }
        @inlinable static var cornerRadius: CGFloat { 4 }
        @inlinable static var padding: CGFloat { 5 }
        @inlinable static var shadowRadius: CGFloat { 0.5 }
        @inlinable static var shadowOffset: CGSize { CGSize(width: 0, height: 1) }
    }
    
    //MARK: - Properties
    let path: String
    let errorPlaceholder: String?
    
    //MARK: - init(_:)
    init(
        _ path: String,
        errorPlaceholder: String? = nil
    ) {
        self.path = path
        self.errorPlaceholder = errorPlaceholder
    }
    
    //MARK: - body
    var body: some View {
        AsyncImage(url: URL(string: path), content: processPhase)
//            .padding(Drawing.padding)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius))
            .shadow(
                radius: Drawing.shadowRadius,
                x: Drawing.shadowOffset.width,
                y: Drawing.shadowOffset.height
            )
    }
    
    //MARK: - processPhase
    @inlinable
    @ViewBuilder
    func processPhase(_ phase: AsyncImagePhase) -> some View {
        switch phase {
        case let .success(image):
            image
                .resizable()
                .aspectRatio(Drawing.equalsRatio, contentMode: .fit)
            
        case .empty:
            ProgressView()
                .progressViewStyle(.circular)
            
        case let .failure(error):
            ErrorPlaceholder(errorPlaceholder ?? error.localizedDescription)
                .equatable()
            
        @unknown default:
            fatalError()
        }
    }
}

private extension AsyncProductImage {
    //MARK: - ErrorPlaceholder
    struct ErrorPlaceholder: View, Equatable {
        let error: String
        let symbol: String
        
        //MARK: - init(_:)
        @inlinable
        init(_ error: String, symbol: String = "exclamationmark.triangle") {
            self.error = error
            self.symbol = symbol
        }
        
        //MARK: - Body
        var body: some View {
            VStack(alignment: .center) {
                Image(systemName: symbol)
                    .renderingMode(.original)
                    .font(.title)
                    .aspectRatio(Drawing.equalsRatio, contentMode: .fill)
                    
                Text(error)
                    .font(.caption)
            }
            .foregroundStyle(Color.red)
        }
        
        @inlinable
        nonisolated static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.error == rhs.error && lhs.symbol == rhs.symbol
        }
    }
}

//MARK: - Preview
#Preview {
    VStack {
        AsyncProductImage("https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg")
            .frame(width: 120, height: 100)
        
        AsyncProductImage("https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg")
            .frame(width: 120, height: 100)
        
        AsyncProductImage(
            "https://fakestoreapi.com",
            errorPlaceholder: nil // "Something wrong..."
        )
            .frame(width: 120, height: 100)
    }
    .padding()
}
