//
//  CartHeader.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 16.03.2025.
//

import SwiftUI

struct CartHeader: View, Equatable {
    //MARK: - Drawing
    private enum Drawing {
        static var badgeSize: CGSize { CGSize(width: 30, height: 30) }
        static var opacity: Double { 0.2 }
    }
    
    //MARK: - Properties
    let title: String
    let quantity: Int
    
    //MARK: - init(_:)
    @inlinable
    init(_ title: String, quantity: Int) {
        self.title = title
        self.quantity = quantity
    }
    
    @inlinable
    init(dataSource: DataSource) {
        self.init(dataSource.title, quantity: dataSource.total)
    }
    
    //MARK: - body
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle.bold())
            
            Text(quantity.description)
                .font(.headline)
                .withSize(Drawing.badgeSize)
                .background(Color.blue.opacity(Drawing.opacity))
                .clipShape(Circle())
            
            Spacer()
        }
    }
}
 
extension CartHeader {
    //MARK: - Header
    struct DataSource: Equatable {
        let title: String
        let total: Int
        
        @inlinable init(_ title: String, total: Int) {
            self.title = title
            self.total = total
        }
    }
}

#Preview {
    VStack {
        CartHeader("Cart", quantity: 2)
        Spacer()
    }
    .padding(.horizontal)
}
