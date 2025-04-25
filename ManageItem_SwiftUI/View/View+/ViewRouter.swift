//
//  ViewRouter.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import Foundation

class ViewRouter: ObservableObject {
    enum Screen {
        case auth
        case main
        case add
        case setting
    }

    @Published var currentScreen: Screen = .auth
}
