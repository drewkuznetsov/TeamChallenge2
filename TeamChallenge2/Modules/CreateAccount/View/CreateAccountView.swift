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
        static let horizontalPadding: CGFloat = 20
        static let bottomPadding: CGFloat = 55
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
                
                AuthStack(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    emailPlaceholder: viewModel.model.emailFieldPlaceholder,
                    passwordPlaceholder: viewModel.model.passwordFieldPlaceholder,
                    upperButtonTitle: viewModel.model.upperButtonTitle,
                    upperbuttonAction: viewModel.createAccount,
                    lowerButtonTitle: viewModel.model.bottomButtonTitle,
                    lowerbuttonAction: { dismiss() }
                )
                
                Spacer()
                    .frame(maxHeight: Drawing.bottomPadding)
            }
            .padding(.horizontal, Drawing.horizontalPadding)
        }
        .onAppear(perform: viewModel.onAppear )
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
