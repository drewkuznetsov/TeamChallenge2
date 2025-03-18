//
//  ColorsPreView.swift
//  TeamChallenge2
//
//  Created by Gerodot on 15.03.2025.
//


import SwiftUI

// MARK: - Colors Preview View

struct ColorsPreView: View {
    fileprivate let colors: [(Color, String)] = [
        // Основные цвета текста
        (.primaryText,      "Primary Text"),
        (.secondaryText,    "Secondary Text"),
        (.tertiaryText,     "Tertiary Text"),
        
        // Акцентные цвета
        (.accentBlue,       "Accent Blue"),
        (.brightBlue,       "Bright Blue"),
        
        // Фоновые цвета
        (.lightBackground,  "Light Background"),
        (.darkBackground,   "Dark Background"),
        
        // Фоновая заливка элементов
        (.primaryBackground,     "Primary Background Background"),
        (.secondaryBackground,   "Secondary Background Backgound"),
        (.tertiaryBackground,    "Tertiary Background Backgound"),
        (.searchBackground,    "Seach Background Backgound"),
        
        
        // Цвета кнопок
        (.buttonPrimary,    "Button Primary"),
        (.buttonSecondary,  "Button Secondary"),
        (.buttonText,       "Button Text"),
        
        // Специальные элементы
        (.searchField,      "Search Field"),
        (.BackgroundText,   "Background Text"),
        
        // Градиенты
        (.gradientStart,    "Gradient Start"),
        (.gradientEnd,      "Gradient End"),
    ]
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(colors, id: \.1) { color, name in
                    HStack() {
                        color
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primaryText.opacity(0.2)
                                           )
                            )
                        
                        VStack(alignment: .leading) {
                            Text(name)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primaryText)
                            
                            Text(color.description)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.secondaryText)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Color Palette")
        }
    }
}

#Preview {
    ColorsPreView()
}
