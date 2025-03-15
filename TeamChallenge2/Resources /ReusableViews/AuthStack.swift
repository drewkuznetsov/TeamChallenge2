//
//  LoginStack.swift
//  TeamChallenge2
//
//  Created by nikita on 15.03.25.
//

import SwiftUI

struct AuthStack: View {
    private enum Drawing {
        static let fieldsSpacing: CGFloat = 18
        static let fieldsHeight: CGFloat = 52
        static let fieldsFontSize: CGFloat = 14
        static let textFieldsColor: Color = Color.gray.opacity(0.25)
        static let fieldsBottomPadding: CGFloat = 62
        static let buttonsSpacing: CGFloat = 18
        static let upperButtonCornerRadius: CGFloat = 16
        static let upperButtonHeight: CGFloat = 61
        static let upperButtonFontSize: CGFloat = 22
        static let lowerButtonFontSize: CGFloat = 15
    }
    
    @Binding var email: String
    @Binding var password: String
    
    let emailPlaceholder: String
    let passwordPlaceholder: String
    let upperButtonTitle: String
    let upperbuttonAction: () -> Void
    let lowerButtonTitle: String
    let lowerbuttonAction: () -> Void
    
    var body: some View {
        VStack(spacing: Drawing.fieldsSpacing) {
            RoundTextField(
                text: $email,
                placeholder: emailPlaceholder,
                onSubmit: {},
                height: Drawing.fieldsHeight,
                fontSize: Drawing.fieldsFontSize,
                backgroundColor: Drawing.textFieldsColor,
                isHiddeble: false
            )
            
            RoundTextField(
                text: $password,
                placeholder: passwordPlaceholder,
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
            Button(action: upperbuttonAction) {
                ColorRectangleView(
                    cornerRadius: Drawing.upperButtonCornerRadius,
                    text: upperButtonTitle,
                    height: Drawing.upperButtonHeight,
                    backgroundColor: Color.shopBlue,
                    textColor: Color.white,
                    fontSize: Drawing.upperButtonFontSize
                )
            }
            
            Button(action: lowerbuttonAction) {
                Text(lowerButtonTitle)
                    .font(
                        Font.system(
                            size: Drawing.lowerButtonFontSize
                        )
                    )
                    .foregroundStyle(Color.primary)
                    .padding()
            }
        }
    }
}
