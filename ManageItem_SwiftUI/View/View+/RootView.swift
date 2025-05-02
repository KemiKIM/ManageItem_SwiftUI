//
//  RootView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/27/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewRouter: ViewRouter
   
    
    
    var body: some View {
        
        NavigationStack(path: $viewRouter.path) {
            Color.clear // = Launcher Screen
                .onAppear {
                    
                    // Init: Set iPhone Screen Size
                    self.set_iPhoneScreenSize()
                    
                    // Init: AuthView
                    if viewRouter.path.isEmpty {
                        viewRouter.navigate(to: .auth)
                    }
                }
            
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .auth:
                        AuthView()
                    case .main:
                        MainView()
                    case .add(let title, let receiveLabels):
                        AddView(title: title, receiveLabels: receiveLabels)
                    case .setting:
                        SettingView()
                    case .experience:
                        ExperienceView()
                    }
                }
        }
    }
    
    
    
    // Set iPhone Screen Size
    func set_iPhoneScreenSize() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let screenSize = windowScene.screen.bounds.size as CGSize? {
            
            MANGO.info("Set iPhone Screen Size: \(screenSize)")
            UserDefaults.standard.set(screenSize.width, forKey: "iPhoneScreen_Width")
            UserDefaults.standard.set(screenSize.height, forKey: "iPhoneScreen_Height")
            
        } else {
            MANGO.error("Unable to set iPhone Screen Size.")
        }
    }
}

