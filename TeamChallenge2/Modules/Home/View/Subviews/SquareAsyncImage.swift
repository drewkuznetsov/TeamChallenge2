//
//  SquareAsyncImage.swift
//  TeamChallenge2
//
//  Created by Gerodot on 14.03.2025.
//

import SwiftUI

struct SquareAsyncImage: View {
    let url: URL
    let size: CGFloat
    var alignment: Alignment = .center
    var scaleType: ContentMode = .fill

    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: scaleType)
                    .frame(width: size, height: size)
                    .clipped()
            } else {
                // Плейсхолдер во время загрузки
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.5))
                        .background(.regularMaterial)
                        .modifier(ShimmerEffect())
                        .redacted(reason: .placeholder)
                }
            }
        }
        .frame(width: size, height: size, alignment: alignment) // Фиксируем размер вью
        .clipShape(RoundedRectangle(cornerRadius: 5)) // Скругляем углы
    }
}

#Preview {
    SquareAsyncImage(url: ProductBO.makeStubProductBO().image, size: 200)
}
