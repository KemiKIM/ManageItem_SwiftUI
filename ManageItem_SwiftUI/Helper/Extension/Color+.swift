//
//  UIColor+.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import UIKit
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    
    
    static let mSignature = Color(hex: "00BFFE")
}


extension Color {
    
    static let mBackground = Color(UIColor.mBackground)
    static let adaptiveBackground = Color(UIColor.adaptiveBackground)
    
    static let tabbarShadow = Color(UIColor.tabbarShadow)
}


extension UIColor {
    
    static var mBackground: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? .black
            : .secondarySystemBackground
        })
    }

    static var adaptiveBackground: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor.systemGray6
            : UIColor.white
        })
    }

    static var tabbarShadow: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.1)
            : UIColor.black.withAlphaComponent(0.15)
        })
    }

}
