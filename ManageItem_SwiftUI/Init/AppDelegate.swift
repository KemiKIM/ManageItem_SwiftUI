//
//  AppDelegate.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/18/25.
//

import SwiftUI
import SwiftyBeaver
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        // Firebase
        FirebaseApp.configure()
        
        return true
    }
}
