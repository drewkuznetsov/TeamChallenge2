//
//  QuantityStepper.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 20.03.2025.
//

import SwiftUI

struct QuantityStepper: View {
    private enum Drawing {
        static var elementSize: CGFloat { 30 }
        static var opacity: Double { 0.2 }
        static var cornerRadius: CGFloat { 6 }
        static var valuePadding: CGFloat { 8 }
        static var spacing: CGFloat { 5 }
    }
    
    @Binding var quantity: Int
    let range: ClosedRange<Int>
    
    //MARK: - init(_:)
    init(
        _ quantity: Binding<Int>,
        in range: ClosedRange<Int> = 0...Int.max
    ) {
        self._quantity = quantity
        self.range = range
    }
    
    //MARK: - body
    var body: some View {
        HStack(spacing: Drawing.spacing) {
            ButtonIcon(
                .minusCircle,
                size: Drawing.elementSize,
                action: decrease
            )
                .equatable()
            
            Text(quantity.description)
                .padding(Drawing.valuePadding)
                .frame(minWidth: Drawing.elementSize)
                .background(Color.blue.opacity(Drawing.opacity))
                .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius))
            
            ButtonIcon(
                .plusCircle,
                size: Drawing.elementSize,
                action: increase
            )
                .equatable()
        }
    }
    
}

//MARK: - Private methods
private extension QuantityStepper {
    func increase() {
        if range.last == quantity { return }
        quantity += 1
    }
    
    func decrease() {
        if range.first == quantity { return }
        quantity -= 1
    }
}

#Preview {
    VStack {
        QuantityStepper(.constant(2000))
        QuantityStepper(.constant(200))
        QuantityStepper(.constant(2))
        QuantityStepper(.constant(20))
    }
}
