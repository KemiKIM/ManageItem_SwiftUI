//
//  AppColorMode.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/5/25.
//

import UIKit
import SwiftUI

enum AppColorMode: String, CaseIterable, Identifiable {
    case system, light, dark
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .system: return "시스템 설정 사용"
        case .light: return "라이트 모드"
        case .dark: return "다크 모드"
        }
    }
}

func applyAppColorMode(_ mode: AppColorMode) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }

    switch mode {
    case .system:
        window.overrideUserInterfaceStyle = .unspecified
    case .light:
        window.overrideUserInterfaceStyle = .light
    case .dark:
        window.overrideUserInterfaceStyle = .dark
    }
}
