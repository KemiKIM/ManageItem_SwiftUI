//
//  ManageItem_SwiftUIApp.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/18/25.
//

import SwiftUI

@main
struct ManageItem_SwiftUIApp: App {
    // AppDelegate 연결
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
