//
//  Screen.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/27/25.
//

enum Screen: Hashable {
    case auth
    case main
    case add(title: String, receiveLabels: [String])
    case setting
    case experience
}
