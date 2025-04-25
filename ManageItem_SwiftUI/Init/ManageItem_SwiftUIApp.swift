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
    
    // Lottie 감지를 위한
    // 전역 ViewModel
    @StateObject private var rdViewModel = RDViewModel()
    @StateObject var viewRouter = ViewRouter()
    
    
    
    
    // 초기화
    init() {
        configureSwiftyBeaver()
        
    }
    
    
    // Body
    var body: some Scene {
        WindowGroup {
            
            Group {
                switch viewRouter.currentScreen {
                case .auth:
                    AuthView(
                        onSuccess: {
                            viewRouter.currentScreen = .main
                        }
                    )
                case .main:
                    MainView()
                case .add:
                    AddView()
                case .setting:
                    SettingView()
                }
            }
            .environmentObject(viewRouter)
            .environmentObject(rdViewModel)
            
            
        }
    }

    
}

