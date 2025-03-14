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
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ZStack{
                Rectangle()
                    .fill(.background.opacity(0))
                    .background(.thinMaterial)
                ProgressView()
                    .opacity(0.5)
            }
        }
        .frame(width: size, height: size)
        .clipShape(.rect(cornerRadius: 5))
    }
}

#Preview {
    SquareAsyncImage(url: ProductBO.makeStubProductBO().image, size: 200)
}
