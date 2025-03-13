//
//  StartView.swift
//  TeamChallenge2
//
//  Created by nikita on 11.03.25.
//

import SwiftUI

struct StartView: View {
    private enum Drawing {
        static let imageSize: CGFloat = 134
        static let titleFont: CGFloat = 52
        static let buttonsSpacing: CGFloat = 18
        static let upperButtonCornerRadius: CGFloat = 16
        static let upperButtonHeight: CGFloat = 61
        static let upperButtonFontSize: CGFloat = 22
        static let horizontalPadding: CGFloat = 20
        static let bottomPadding: CGFloat = 55
        static let lowerButtonFontSize: CGFloat = 15
        static let lowerButtonImageName = "arrow.right.circle.fill"
        static let lowerButtonImageSize: CGFloat = 30
    }
    
    let viewModel = StartViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack {
                    Circle()
                        .frame(width: Drawing.imageSize, height: Drawing.imageSize)
                        .foregroundStyle(Color(.systemBackground))
                        .shadow(color: Color.primary.opacity(0.16), radius: 4, x: 0, y: 3)
                        .overlay {
                            Image(viewModel.model.storeLabel)
                        }
                    
                    Text(viewModel.model.storeName)
                        .font(Font.system(size: Drawing.titleFont, weight: .bold))
                }
                
                Spacer()
                
                VStack(spacing: Drawing.buttonsSpacing) {
                    NavigationLink(destination: CreateAccountView()) {
                        ColorRectangleView(
                            cornerRadius: Drawing.upperButtonCornerRadius,
                            text: viewModel.model.upperButtonTitle,
                            height: Drawing.upperButtonHeight,
                            backgroundColor: Color.shopBlue,
                            textColor: Color.white,
                            fontSize: Drawing.upperButtonFontSize
                        )
                    }
                    
                    NavigationLink(destination: CreateAccountView()) {
                        HStack {
                            Text(viewModel.model.bottomButtonTitle)
                                .font(Font.system(size: Drawing.lowerButtonFontSize))
                                .foregroundStyle(Color.primary)
                                .padding()
                            
                            Image(systemName: Drawing.lowerButtonImageName)
                                .resizable()
                                .frame(
                                    width: Drawing.lowerButtonImageSize,
                                    height: Drawing.lowerButtonImageSize
                                )
                        }
                    }
                }
                .padding(.horizontal, Drawing.horizontalPadding)
                .padding(.bottom, Drawing.bottomPadding)
            }
        }
    }
}

#Preview {
    StartView()
}
