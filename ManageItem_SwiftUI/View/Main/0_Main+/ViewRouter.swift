//
//  ViewRouter.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI

class ViewRouter: ObservableObject {
   
    @Published var mainPath = NavigationPath()
    @Published var zonePath = NavigationPath()
    @Published var settingPath = NavigationPath()

    
    // Push
    func navigateMain(to screen: MainScreen) {
        mainPath.append(screen)
    }
    
    func navigateZone(to screen: ZoneScreen) {
        zonePath.append(screen)
    }
    
    func navigateSetting(to screen: SettingScreen) {
        settingPath.append(screen)
    }
    
    
    // Pop
    func popMain() {
        if !mainPath.isEmpty {
            mainPath.removeLast()
        }
    }
    
    func popZone() {
        if !zonePath.isEmpty {
            zonePath.removeLast()
        }
    }
    
    func popSetting() {
        if !settingPath.isEmpty {
            settingPath.removeLast()
        }
    }
    
    
    
}
