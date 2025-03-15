//
//  Colors.swift
//  TeamChallenge2
//
//  Created by Gerodot on 14.03.2025.
//

import SwiftUI

extension Color {
    // Основные цвета текста
    static let primaryText      = Color(hex: "#212121") // Основной текст
    static let secondaryText    = Color(hex: "#383F42") // Вторичный текст
    static let tertiaryText     = Color(hex: "#C7C7CC") // Третичный текст
    
    // Акцентные цвета
    static let accentBlue       = Color(hex: "#0043E0") // Основной акцент
    static let brightBlue       = Color(hex: "#004CFF") // Яркий акцент
    
    // Фоновые цвета
    static let lightBackground  = Color(hex: "#F2F2F2") // Светлый фон
    static let darkBackground   = Color(hex: "#1A1A1A") // Темный фон
    
    // Беййджи и прочие элементы
    static let primaryBackground     = Color(hex: "#E5EBFC") // Основной фон
    static let secondaryBackground   = Color(hex: "#F5F8FF") // Вторичный фон
    static let tertiaryBackground    = Color(hex: "#F9F9F9") // Третичный фон
    static let searchBackground      = Color(hex: "F8F8F8FF") // Фон поиска
    
    // Цвета кнопок
    static let buttonPrimary    = Color(hex: "#004DFF") // Основная кнопка
    static let buttonSecondary  = Color(hex: "#D1D1D1") // Вторичная кнопка
    static let buttonText       = Color(hex: "#FFFFFF") // Текст на кнопках
    
    // Специфические элементы
    static let searchField      = Color(hex: "#004AFF") // Поле поиска
    static let BackgroundText   = Color(hex: "#0043E0") // Текст бейджей
    
    // Градиенты и дополнительные
    static let gradientStart    = Color(hex: "#0043E0") // Начало градиента
    static let gradientEnd      = Color(hex: "#0066FF") // Конец градиента
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

fileprivate struct ColorPreview: View {
    private let colors: [(Color, String)] = [
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
    ColorPreview()
}
