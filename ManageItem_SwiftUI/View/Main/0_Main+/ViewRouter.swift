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

    
//    @Published var pathTabA = NavigationPath()
//    @Published var pathTabB = NavigationPath()
//    @Published var pathTabC = NavigationPath()
//  
//    
//    func navigateA(to screen: MainScreen) {
//        pathTabA.append(screen)
//    }
//    
//    
//    func navigateB(to screen: ZoneScreen) {
//        pathTabB.append(screen)
//    }
//    
//    
//    func navigateC(to screen: SettingScreen) {
//        pathTabC.append(screen)
//    }
//    
//    func popA() {
//        if !pathTabA.isEmpty {
//            pathTabA.removeLast()
//        }
//    }
//    
//    func popB() {
//        if !pathTabB.isEmpty {
//            pathTabB.removeLast()
//        }
//    }
//    
//    func popC() {
//        if !pathTabC.isEmpty {
//            pathTabC.removeLast()
//        }
//    }
    
    
    
    // Natigate
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
