//
//  StartView.swift
//  TeamChallenge2
//
//  Created by nikita on 11.03.25.
//

import SwiftUI

struct CreateAccountView: View {
    private enum Drawing {
        static let screenLabelTextSize: CGFloat = 50
        static let screenLabelWidth: CGFloat = 200
        static let screenLabelTopPadding: CGFloat = 78
        static let screenLabelLeadingPadding: CGFloat = 30
        static let buttonsSpacing: CGFloat = 18
        static let upperButtonHeight: CGFloat = 61
        static let upperButtonCornerRadius: CGFloat = 16
        static let upperButtonFontSize: CGFloat = 22
        static let horizontalPadding: CGFloat = 20
        static let bottomPadding: CGFloat = 55
        static let lowerButtonFontSize: CGFloat = 15
    }
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CreateAccountViewModel()
    
    var body: some View {
        ZStack {
            Image(.createAccountBackground)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text(viewModel.model.screenLabel)
                        .font(
                            Font.system(
                                size: Drawing.screenLabelTextSize,
                                weight: .bold
                            )
                        )
                        .frame(width: Drawing.screenLabelWidth)
                    
                    Spacer()
                }
                .padding(.leading, Drawing.screenLabelLeadingPadding)
                .padding(.top, Drawing.screenLabelTopPadding)
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                }
                
                VStack(spacing: Drawing.buttonsSpacing) {
                    Button(action: viewModel.createAccount) {
                        ColorRectangleView(
                            cornerRadius: Drawing.upperButtonCornerRadius,
                            text: viewModel.model.upperButtonTitle,
                            height: Drawing.upperButtonHeight,
                            backgroundColor: Color.shopBlue,
                            textColor: Color.white,
                            fontSize: Drawing.upperButtonFontSize
                        )
                    }
                    .padding(.horizontal, Drawing.horizontalPadding)
                    
                    Button(action: { dismiss() }) {
                        Text(viewModel.model.bottomButtonTitle)
                            .font(
                                Font.system(
                                    size: Drawing.lowerButtonFontSize
                                )
                            )
                            .foregroundStyle(Color.primary)
                            .padding()
                    }
                }
                .padding(.bottom, Drawing.bottomPadding)
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigateToHome) {
                HomeView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CreateAccountView()
}
