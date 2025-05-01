//
//  UIScreen+.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/30/25.
//

import UIKit

extension UIScreen {
    
    // Screen Width
    static var screenWidth: CGFloat {
        return CGFloat(UserDefaults.standard.double(forKey: "iPhoneScreen_Width"))
    }
    
    // Screen Height
    static var screenHeight: CGFloat {
        return CGFloat(UserDefaults.standard.double(forKey: "iPhoneScreen_Height"))
    }
}
