//
//  Fonts.swift
//  TeamChallenge2
//
//  Created by Gerodot on 14.03.2025.
//

import SwiftUI

// MARK: - Font Extension

extension Font {
    // Raleway
    static let screenTitle = Font.custom("Raleway", size: 52).weight(.bold)
    static let sectionHeader = Font.custom("Raleway", size: 28).weight(.bold)
    static let cardTitle = Font.custom("Raleway", size: 21).weight(.bold)
    static let bodyBold = Font.custom("Raleway", size: 17).weight(.bold)
    static let seachText = Font.custom("Raleway", size: 16).weight(.medium)
    static let actionText = Font.custom("Raleway", size: 15).weight(.bold)
    static let captionBold = Font.custom("Raleway", size: 12).weight(.bold)
    
    // Nunito Sans
    static let bodyRegular = Font.custom("NunitoSans", size: 12).weight(.regular)
    static let bodyLight = Font.custom("NunitoSans", size: 19).weight(.light)
    static let buttonText = Font.custom("NunitoSans", size: 16).weight(.light)
    static let cardAction = Font.custom("NunitoSans", size: 22).weight(.light)
    
    // Inter
    static let microText = Font.custom("Inter", size: 10).weight(.regular)
    static let statusText = Font.custom("Inter", size: 12).weight(.medium)
    static let actioText = Font.custom("Inter", size: 12).weight(.regular)
    
    // Poppins
    static let formText = Font.custom("Poppins-Medium", size: 14)
}

// MARK: - Main View

fileprivate struct FontsAndColorsTestView: View {
    private let fontWeights = FontWeight.allCases
    private let customFonts = CustomFont.allCases
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(customFonts, id: \.self) { fontStyle in
                    CustomFontSection(style: fontStyle)
                }
            
                ForEach(fontWeights, id: \.self) { weight in
                    FontWeightSection(weight: weight)
                }
            }
            .navigationTitle("Fonts Preview")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview Data

fileprivate enum PreviewTextType: String, CaseIterable {
    case numbers = "1234567890"
    case uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    case lowercase = "abcdefghijklmnopqrstuvwxyz"
    
    var title: String {
        switch self {
        case .numbers: return "Numbers"
        case .uppercase: return "Uppercase"
        case .lowercase: return "Lowercase"
        }
    }
}

// MARK: - Data Models

fileprivate enum FontWeight: String, CaseIterable {
    case ultraLight = "Ultra Light"
    case thin = "Thin"
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
    case heavy = "Heavy"
    case black = "Black"
    
    var systemWeight: Font.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        }
    }
}

fileprivate enum CustomFont: String, CaseIterable {
    case screenTitle
    case sectionHeader
    case cardTitle
    case bodyBold
    case captionBold
    case bodyLight
    case buttonText
    case microText
    case statusText
    case formText
    
    var font: Font {
        switch self {
        case .screenTitle: return .screenTitle
        case .sectionHeader: return .sectionHeader
        case .cardTitle: return .cardTitle
        case .bodyBold: return .bodyBold
        case .captionBold: return .captionBold
        case .bodyLight: return .bodyLight
        case .buttonText: return .buttonText
        case .microText: return .microText
        case .statusText: return .statusText
        case .formText: return .formText
        }
    }
    
    var description: String {
        switch self {
        case .screenTitle: return "Screen Title (Raleway-Bold 52)"
        case .sectionHeader: return "Section Header (Raleway-Bold 28)"
        case .cardTitle: return "Card Title (Raleway-Bold 21)"
        case .bodyBold: return "Body Bold (Raleway-Bold 17)"
        case .captionBold: return "Caption Bold (Raleway-Bold 12)"
        case .bodyLight: return "Body Light (NunitoSans-Light 19)"
        case .buttonText: return "Button Text (NunitoSans-Light 16)"
        case .microText: return "Micro Text (Inter-Regular 10)"
        case .statusText: return "Status Text (Inter-Medium 12)"
        case .formText: return "Form Text (Poppins-Medium 14)"
        }
    }
}

// MARK: - Font Weight Section

fileprivate struct FontWeightSection: View {
    let weight: FontWeight
    let size: CGFloat = 18
    
    var body: some View {
        Section(weight.rawValue) {
            ForEach(PreviewTextType.allCases, id: \.self) { type in
                VStack(alignment: .leading) {
                    Text(type.title)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(type.rawValue)
                        .font(.system(size: size, weight: weight.systemWeight))
                }
                .padding(.vertical, 8)
            }
        }
    }
}


// MARK: - Custom Font Section

fileprivate struct CustomFontSection: View {
    let style: CustomFont
    
    var body: some View {
        Section(style.description) {
            ForEach(PreviewTextType.allCases, id: \.self) { type in
                VStack(alignment: .leading) {
                    Text(type.title)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(type.rawValue)
                        .font(style.font)
                }
                .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FontsAndColorsTestView()
}
