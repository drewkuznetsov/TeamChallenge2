//
//  Fonts.swift
//  TeamChallenge2
//
//  Created by Gerodot on 14.03.2025.
//

import SwiftUI

/// Provides custom font styles with Dynamic Type support
///
/// This extension adds support for custom fonts:
/// - Raleway
/// - Nunito Sans
/// - Inter
/// - Poppins (Medium weight)
///
/// Offers two sizing modes:
/// 1. Adaptive sizing based on `UIFont.TextStyle`
/// 2. Fixed point sizing
extension Font {
    
    // MARK: - Raleway
    
    /// Creates an adaptive Raleway font for the specified text style
    /// - Parameter style: The text style for dynamic type scaling (default: .body)
    /// - Returns: Custom Raleway font scaled to match the text style
    /// - Note: Automatically adapts to user's Dynamic Type settings
    ///
    /// # Usage
    /// ```
    /// Text("Adaptive Title")
    ///     .font(.raleway(.title))
    /// ```
    static func raleway(_ style: UIFont.TextStyle = .body) -> Font {
        custom("Raleway", size: UIFont.preferredFont(forTextStyle: style).pointSize)
    }
    
    /// Creates a Raleway font with fixed point size
    /// - Parameter fixedSize: The font size in points
    /// - Returns: Custom Raleway font with specified size
    /// - Important: Fixed sizes ignore Dynamic Type accessibility settings
    ///
    /// # Usage
    /// ```
    /// Text("Fixed Size")
    ///     .font(.raleway(fixedSize: 24))
    /// ```
    static func raleway(fixedSize: CGFloat) -> Font {
        custom("Raleway", size: fixedSize)
    }
    
    // MARK: - Nunito Sans
    
    /// Creates an adaptive Nunito Sans font for the specified text style
    /// - Parameter style: The text style for dynamic type scaling (default: .body)
    /// - Returns: Custom Nunito Sans font scaled to match the text style
    /// - Note: Uses regular weight variant
    ///
    /// # Usage
    /// ```
    /// Text("Headline Text")
    ///     .font(.nunitoSans(.headline))
    /// ```
    static func nunitoSans(_ style: UIFont.TextStyle = .body) -> Font {
        custom("NunitoSans", size: UIFont.preferredFont(forTextStyle: style).pointSize)
    }
    
    /// Creates a Nunito Sans font with fixed point size
    /// - Parameter fixedSize: The font size in points
    /// - Returns: Custom Nunito Sans font with specified size
    static func nunitoSans(fixedSize: CGFloat) -> Font {
        custom("NunitoSans", size: fixedSize)
    }
    
    // MARK: - Inter
    
    /// Creates an adaptive Inter font for the specified text style
    /// - Parameter style: The text style for dynamic type scaling (default: .body)
    /// - Returns: Custom Inter font scaled to match the text style
    /// - Note: Uses regular weight variant by default
    ///
    /// # Usage
    /// ```
    /// Text("Body Text")
    ///     .font(.inter())
    /// ```
    static func inter(_ style: UIFont.TextStyle = .body) -> Font {
        custom("Inter", size: UIFont.preferredFont(forTextStyle: style).pointSize)
    }
    
    /// Creates an Inter font with fixed point size
    /// - Parameter fixedSize: The font size in points
    /// - Returns: Custom Inter font with specified size
    static func inter(fixedSize: CGFloat) -> Font {
        custom("Inter", size: fixedSize)
    }
    
    // MARK: - Poppins
    
    /// Creates an adaptive Poppins Medium font for the specified text style
    /// - Parameter style: The text style for dynamic type scaling (default: .body)
    /// - Returns: Custom Poppins Medium font scaled to match the text style
    /// - Important: Weight is embedded in font name (Medium)
    ///
    /// # Usage
    /// ```
    /// Text("Poppins Medium")
    ///     .font(.poppins(.largeTitle))
    /// ```
    static func poppins(_ style: UIFont.TextStyle = .body) -> Font {
        custom("Poppins-Medium", size: UIFont.preferredFont(forTextStyle: style).pointSize)
    }
    
    /// Creates a Poppins Medium font with fixed point size
    /// - Parameter fixedSize: The font size in points
    /// - Returns: Custom Poppins Medium font with specified size
    static func poppins(fixedSize: CGFloat) -> Font {
        custom("Poppins-Medium", size: fixedSize)
    }
}

// MARK: - Role-based Font Modifiers (HIG Compliant)
extension Font {
    // MARK: Raleway
    
    static let screenTitle      = Font.custom("Raleway", size: 52).weight(.bold)
    static let sectionHeader    = Font.custom("Raleway", size: 28).weight(.bold)
    static let cardTitle        = Font.custom("Raleway", size: 21).weight(.bold)
    static let bodyBold         = Font.custom("Raleway", size: 17).weight(.bold)
    static let searchText       = Font.custom("Raleway", size: 16).weight(.medium)
    static let actionText       = Font.custom("Raleway", size: 15).weight(.bold)
    static let captionBold      = Font.custom("Raleway", size: 12).weight(.bold)

    // MARK: Nunito Sans
    
    static let bodyRegular      = Font.custom("NunitoSans", size: 12).weight(.regular)
    static let bodyLight        = Font.custom("NunitoSans", size: 19).weight(.light)
    static let buttonText       = Font.custom("NunitoSans", size: 16).weight(.light)
    static let cardAction       = Font.custom("NunitoSans", size: 22).weight(.light)

    // MARK: Inter
    
    static let microText        = Font.custom("Inter", size: 10).weight(.regular)
    static let statusText       = Font.custom("Inter", size: 12).weight(.medium)
    static let secondaryActionText = Font.custom("Inter", size: 12).weight(.regular)

    // MARK: Poppins
    
    static let formText = Font.custom("Poppins-Medium", size: 14)
}

// MARK: - Preview

#Preview {
    FontsPreView()
}
