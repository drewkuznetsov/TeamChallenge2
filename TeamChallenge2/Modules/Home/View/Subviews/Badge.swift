//
//  Badge.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 09.03.2025.
//

import SwiftUI

struct Badge: View {
    let amount: Int
    var body: some View {
        Text(amount.formatted())
            .font(.system(size: 7.5))
            .foregroundStyle(.white)
            .padding(EdgeInsets(top: 1.5, leading: 3.5, bottom: 1.5, trailing: 3.5))
            .background(
                RoundedRectangle(cornerRadius: .infinity)
                    .fill(.red)
            )
    }
}

#Preview {
    Badge(amount: 2)
}
