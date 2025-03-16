//
//  TotalBar.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 16.03.2025.
//

import SwiftUI

struct TotalBar: View, Equatable {
    private enum Drawing {
        static var opacity: Double { 0.15 }
    }
    
    //MARK: - Properties
    let total: Double
    let buttonTitle: String
    let checkout: () -> Void
    
    //MARK: - init(_:)
    init(_ total: Double, buttonTitle: String, checkout: @escaping () -> Void) {
        self.total = total
        self.buttonTitle = buttonTitle
        self.checkout = checkout
    }
    
    //MARK: - body
    var body: some View {
        HStack {
            Text("Total $".appending(total.description))
                .font(.title2.bold())
            Spacer()
            Button(action: checkout) {
                Text(buttonTitle)
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color.gray.opacity(Drawing.opacity))
    }
    
    @inlinable
    nonisolated static func == (lhs: TotalBar, rhs: TotalBar) -> Bool {
        lhs.total == rhs.total && lhs.buttonTitle == rhs.buttonTitle
    }
}

#Preview {
    VStack {
        TotalBar(15.45, buttonTitle: "Pay", checkout: {})
    }
}
