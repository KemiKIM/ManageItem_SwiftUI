//
//  UIApplication+.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/23/25.
//

import UIKit

extension UIApplication {
    func downKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
