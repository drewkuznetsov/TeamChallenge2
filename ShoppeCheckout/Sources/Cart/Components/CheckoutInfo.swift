//
//  CheckoutInfo.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 16.03.2025.
//

import SwiftUI

struct CheckoutInfo: View, Equatable {
    //MARK: - Drawing
    private enum Drawing {
        static var iconSize: CGSize { CGSize(width: 30, height: 30) }
        static var opacity: Double { 0.15 }
        static var cornerRadius: CGFloat { 8 }
    }
    
    //MARK: - Properties
    let title: String
    let text: String
    let changeTap: () -> Void

    //MARK: - init(_:)
    @inlinable
    init(_ title: String, text: String, changeTap: @escaping () -> Void) {
        self.title = title
        self.text = text
        self.changeTap = changeTap
    }
    
    @inlinable
    init(_ info: Info) {
        self.init(info.title, text: info.text, changeTap: info.change)
    }
    
    //MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline.bold())
            HStack {
                Text(text)
                    .font(.caption)
                Spacer()
                Button(action: changeTap) {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                }
                .withSize(Drawing.iconSize)
            }
        }
        .padding()
        .background(Color.gray.opacity(Drawing.opacity))
        .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius))
    }
    
    @inlinable
    nonisolated static func == (lhs: CheckoutInfo, rhs: CheckoutInfo) -> Bool {
        lhs.title == rhs.title && lhs.text == rhs.text
    }
    
}

extension CheckoutInfo {
    struct Info: Equatable {
        let title: String
        let text: String
        let change: () -> Void
        
        @inlinable
        static func == (lhs: CheckoutInfo.Info, rhs: CheckoutInfo.Info) -> Bool {
            lhs.title == rhs.text && lhs.text == rhs.text
        }
    }
}

#Preview {
    CheckoutInfo(
        "Shipping address",
        text: "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
        changeTap: { }
    )
}
