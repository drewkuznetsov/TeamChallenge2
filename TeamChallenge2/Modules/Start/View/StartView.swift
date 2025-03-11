//
//  StartView.swift
//  TeamChallenge2
//
//  Created by nikita on 11.03.25.
//

import SwiftUI

struct StartView: View {
    let viewModel = StartViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack {
                    Circle()
                        .frame(width: 134, height: 134)
                        .foregroundStyle(Color.white)
                        .shadow(color: Color.primary.opacity(0.16), radius: 4, x: 0, y: 3)
                        .overlay {
                            Image(viewModel.model.storeLabel)
                        }
                    
                    Text(viewModel.model.storeName)
                        .font(Font.system(size: 52, weight: .bold))
                }
                
                Spacer()
                
                VStack(spacing: 18) {
                    NavigationLink(destination: StartView()) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.shopBlue)
                            .frame(height: 61)
                            .overlay {
                                Text(viewModel.model.upperButtonTitle)
                                    .font(Font.system(size: 22))
                                    .foregroundStyle(Color.white)
                            }
                    }
                    .padding(.horizontal, 20)
                    
                    NavigationLink(destination: StartView()) {
                        HStack {
                            Text(viewModel.model.bottomButtonTitle)
                                .font(Font.system(size: 15))
                                .foregroundStyle(Color.primary)
                                .padding()
                            
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .padding(.bottom, 55)
            }
        }
    }
}

#Preview {
    StartView()
}
