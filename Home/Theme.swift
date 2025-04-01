//
//  Theme.swift
//  Home
//
//  Created by UNKNOWN on 3/31/25.
//

import SwiftUI

// Define the app's color scheme
struct GharTheme {
    // Main colors
    static let primaryColor = Color("GharPrimaryColor")
    static let secondaryColor = Color("GharSecondaryColor")
    static let accent = Color("AccentColor")
    
    // Semantic colors
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.blue
    
    // Background
    static let background = Color("BackgroundColor")
    static let cardBackground = Color("CardBackgroundColor")
    
    // Text
    static let textPrimary = Color("TextPrimaryColor")
    static let textSecondary = Color("TextSecondaryColor")
    static let primaryText = Color("TextPrimaryColor")
}

// Extension to apply theme to various SwiftUI views
extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(GharTheme.cardBackground)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    func primaryButtonStyle() -> some View {
        self
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(GharTheme.accent)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

// Custom modifier for responsive design
struct ResponsiveModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if horizontalSizeClass == .compact {
            // Mobile/compact layout
            content
                .padding(12)
        } else {
            // Desktop/wide layout
            content
                .padding(20)
        }
    }
} 