//
//  WebImage.swift
//  ShoppeCheckout
//
//  Created by Илья Шаповалов on 21.03.2025.
//

import SwiftUI
import ShoppeStore

fileprivate extension AsyncImagePhase {
    init(result: Result<Image, Error>) {
        switch result {
        case let .success(image): self = .success(image)
        case let .failure(error): self = .failure(error)
        }
    }
}

struct WebImage: View {
    //MARK: - Private properties
    @State private var phase: AsyncImagePhase = .empty
    private let fetcher = ShoppeStore.shared
    private let gradient = Gradient(colors: [
        .black.opacity(0.3),
        .black,
        .black.opacity(0.3)
    ])
    
    let url: URL
    
    //MARK: - init(_:)
    init(_ url: URL) { self.url = url }
    
    //MARK: - body
    var body: some View {
        Group {
            switch phase {
            case .empty:
                RoundedRectangle(cornerRadius: 8)
                    .redacted(reason: .placeholder)
                    .mask {
                        LinearGradient(
                            gradient: gradient,
                            startPoint: UnitPoint(x: 0, y: 0),
                            endPoint: UnitPoint(x: 1, y: 1)
                        )
                    }
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                
            case .failure(let error):
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text(error.localizedDescription)
                        .font(.callout)
                }
            @unknown default:
                EmptyView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 10, y: 5)
        .task {
            let result = await fetcher
                .fetchImage(url)
                .flatMap(processImageData(_:))
            phase = AsyncImagePhase(result: result)
        }
    }
    
    private func processImageData(_ data: Data) -> Swift.Result<Image, Error> {
#if canImport(UIKit)
        guard let uiImage = UIImage(data: data) else {
            return .failure(URLError(.cannotDecodeContentData))
        }
        return .success(Image(uiImage: uiImage))
#elseif canImport(AppKit)
        guard let nsImage = NSImage(data: data) else {
            return .failure(URLError(.cannotDecodeContentData))
        }
        return .success(Image(nsImage: nsImage))
#endif
    }
}

extension WebImage: @preconcurrency Equatable {
    @inlinable
    static func == (lhs: WebImage, rhs: WebImage) -> Bool {
        guard lhs.url == rhs.url else {
            return false
        }
        switch (lhs.phase, rhs.phase) {
        case (.empty, .empty): return true
        case (.success, .success): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
    
    
}

#Preview {
    WebImage(CartProduct.sample[0].image)
        .frame(width: 120, height: 100)
}
