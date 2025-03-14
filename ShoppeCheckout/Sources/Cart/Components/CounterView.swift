//
//  CounterView.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 12.03.2025.
//

import SwiftUI

struct CounterView: View {
    @Binding var count: Int
    
    @inlinable
    init(_ count: Binding<Int>) { self._count = count }
    
    var body: some View {
        HStack {
            IconButton(.plusCircle) {
                count += 1
            }
            .equatable()
            
            Text(count.formatted())
                .padding()
                .background(Color.blue.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            IconButton(.minusCircle) {
                count -= 1
            }
            .equatable()
        }
    }
}

#Preview {
    CounterView(.constant(1))
}
