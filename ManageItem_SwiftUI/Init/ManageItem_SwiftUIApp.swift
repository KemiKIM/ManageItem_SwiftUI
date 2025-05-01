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
    
    @StateObject var rdViewModel = RDViewModel()
    @StateObject var viewRouter = ViewRouter()

    
    init() {
        configureSwiftyBeaver()
    }

    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewRouter)
                .environmentObject(rdViewModel)
//            TestView()
//            SettingView()
//                .environmentObject(phoneScreenSize)
//            AddView(title: "", receiveLabels: [])
        }
    }
}

