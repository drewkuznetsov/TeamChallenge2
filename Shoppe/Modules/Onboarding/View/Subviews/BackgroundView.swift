//
//  BackgroundView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 12.03.2025.
//


import SwiftUI

struct BackgroundView : View, Equatable {
    var body: some View {
        Image(.bubbles)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}
