//
//  RootView+SetSize.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/6/25.
//

import SwiftUI

extension RootView {
    //
    func init_iPhoneScreenSize() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let screenSize = windowScene.screen.bounds.size as CGSize? {
            
            MANGO.info("init iPhone Screen Size: \(screenSize)")
            UserDefaults.standard.set(screenSize.width, forKey: "iPhoneScreen_Width")
            UserDefaults.standard.set(screenSize.height, forKey: "iPhoneScreen_Height")
            
        } else {
            MANGO.error("Unable to init iPhone Screen Size.")
        }
    }
}
