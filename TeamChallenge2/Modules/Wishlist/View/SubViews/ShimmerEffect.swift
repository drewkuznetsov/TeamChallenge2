//
//  ShimmerEffect.swift
//  TeamChallenge2
//
//  Created by Gerodot on 18.03.2025.
//


import SwiftUI
import ShoppeStore

public struct ShimmerEffect: ViewModifier {
    
    var loadingState: LoadingState = .loading
    @State var isInitialState: Bool = true
    
    public func body(content: Content) -> some View {
        switch loadingState {
        case .loading:
            content
                .redacted(reason: .placeholder)
                .mask {
                    LinearGradient(
                        gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                        startPoint: (isInitialState ? .init(x: -5, y: -5) : .init(x: 1, y: 1)),
                        endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 5, y: 5))
                    )
                }
                .animation(
                    .linear(duration: 1.5).delay(0.5).repeatForever(autoreverses: false),
                    value: isInitialState
                )
                .onAppear() {
                    isInitialState = false
                }
        case .loaded:
            content
            
        }
    }
}
