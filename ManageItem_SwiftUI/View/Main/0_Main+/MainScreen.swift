//
//  MainScreen.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/4/25.
//

import Foundation

enum MainScreen: Hashable {
    case start
    case home(searchText: String?)
    case add(title: String, receiveLabels: [String], noAuth: UUID?)
}

enum ZoneScreen: Hashable {
    case detail(zone: String)
}

enum SettingScreen: Hashable {
    case add(title: String, receiveLabels: [String], noAuth: UUID?)
}
