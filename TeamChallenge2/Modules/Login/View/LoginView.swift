//
//  StartView.swift
//  TeamChallenge2
//
//  Created by nikita on 11.03.25.
//

import SwiftUI

struct LoginView: View {
    private enum Drawing {
        static let screenLabelTextSize: CGFloat = 50
        static let sublabelLabelTextSize: CGFloat = 19
        static let screenLabelTopPadding: CGFloat = 78
        static let screenLabelLeadingPadding: CGFloat = 30
        static let screenLabelBottomPadding: CGFloat = 30
        static let horizontalPadding: CGFloat = 20
        static let bottomPadding: CGFloat = 55
    }
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Image(.loginBackground)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        Text(viewModel.model.screenLabel)
                            .font(
                                Font.system(
                                    size: Drawing.screenLabelTextSize,
                                    weight: .bold
                                )
                            )
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(viewModel.model.sublabelLabel)
                            .font(
                                Font.system(
                                    size: Drawing.sublabelLabelTextSize
                                )
                            )
                        
                        Spacer()
                    }
                }
                
                AuthStack(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    emailPlaceholder: viewModel.model.emailFieldPlaceholder,
                    passwordPlaceholder: viewModel.model.passwordFieldPlaceholder,
                    upperButtonTitle: viewModel.model.upperButtonTitle,
                    upperbuttonAction: viewModel.login,
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
    LoginView()
}
