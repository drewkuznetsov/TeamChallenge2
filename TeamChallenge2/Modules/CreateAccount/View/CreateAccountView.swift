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
        static let screenLabelHight: CGFloat = 120
        static let screenLabelTopPadding: CGFloat = 78
        static let screenLabelLeadingPadding: CGFloat = 30
        static let screenLabelBottomPadding: CGFloat = 30
        static let fieldsSpacing: CGFloat = 18
        static let fieldsHeight: CGFloat = 52
        static let fieldsFontSize: CGFloat = 14
        static let fieldsBottomPadding: CGFloat = 62
        static let buttonsSpacing: CGFloat = 18
        static let upperButtonHeight: CGFloat = 61
        static let upperButtonCornerRadius: CGFloat = 16
        static let upperButtonFontSize: CGFloat = 22
        static let horizontalPadding: CGFloat = 20
        static let bottomPadding: CGFloat = 55
        static let lowerButtonFontSize: CGFloat = 15
        static let textFieldsColor: Color = Color.gray.opacity(0.25)
    }
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CreateAccountViewModel()
    
    var body: some View {
        ZStack {
            Image(.createAccountBackground)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(maxHeight: Drawing.screenLabelTopPadding)
                
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
                .frame(height: Drawing.screenLabelHight)
                .padding(.leading, Drawing.screenLabelLeadingPadding)
                
                Spacer()
                    .frame(minHeight: Drawing.screenLabelBottomPadding)
                
                VStack(spacing: Drawing.fieldsSpacing) {
                    RoundTextField(
                        text: $viewModel.email,
                        placeholder: viewModel.model.emailFieldPlaceholder,
                        onSubmit: {},
                        height: Drawing.fieldsHeight,
                        fontSize: Drawing.fieldsFontSize,
                        backgroundColor: Drawing.textFieldsColor,
                        isHiddeble: false
                    )
                    
                    RoundTextField(
                        text: $viewModel.password,
                        placeholder: viewModel.model.passwordFieldPlaceholder,
                        onSubmit: {},
                        height: Drawing.fieldsHeight,
                        fontSize: Drawing.fieldsFontSize,
                        backgroundColor: Drawing.textFieldsColor,
                        isHiddeble: true
                    )
                }
                
                Spacer()
                    .frame(maxHeight: Drawing.fieldsBottomPadding)
                
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
                
                Spacer()
                    .frame(maxHeight: Drawing.bottomPadding)
            }
            .padding(.horizontal, Drawing.horizontalPadding)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.shouldNavigateToHome) {
            HomeView()
        }
        .alert(isPresented: $viewModel.isAllertPresented) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("ОК"))
            )
        }
    }
}

#Preview {
    CreateAccountView()
}
