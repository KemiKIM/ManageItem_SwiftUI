//
//  ManageItem_SwiftUIApp.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/18/25.
//

import SwiftUI

@main
struct ManageItem_SwiftUIApp: App {
    // AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var hasStarted = false
    
    @AppStorage("appColorMode") private var appColorMode: AppColorMode = .system

    
    init() {
        configureSwiftyBeaver()
    }

    
    var body: some Scene {
        WindowGroup {
            RootView(hasStarted: $hasStarted)
                .onAppear {
                    applyAppColorMode(appColorMode)
                }
            
        }
    }
}

