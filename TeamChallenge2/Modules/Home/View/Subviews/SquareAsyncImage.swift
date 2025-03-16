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
    var anligment: Alignment = .top
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.regularMaterial)
                .modifier(Shimmer())
                .redacted(reason: .placeholder)
            }
        }
        .frame(width: size, height: size, alignment: anligment)
        .clipShape(.rect(cornerRadius: 5))
    }
}

#Preview {
    SquareAsyncImage(url: ProductBO.makeStubProductBO().image, size: 200)
}
