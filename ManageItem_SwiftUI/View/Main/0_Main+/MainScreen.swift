//
//  MainScreen.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/4/25.
//

enum MainScreen: Hashable {
    case start
    case home(searchText: String?)
    case add(title: String, receiveLabels: [String])
}

enum ZoneScreen: Hashable {
    case imagezone(zone: String)
}

enum SettingScreen: Hashable {
    case add(title: String, receiveLabels: [String])
}
