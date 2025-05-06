//
//  RootView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/4/25.
//

import SwiftUI

struct RootView: View {
    let isAuth = UserDefaults.standard.bool(forKey: "hasStarted")
    @Binding var hasStarted: Bool

    @StateObject private var viewRouter = ViewRouter()
    @StateObject private var rdViewModel = RDViewModel()
    
    
    var body: some View {
        // Set UserDefault - iPhone Screen Size
        let _ = init_iPhoneScreenSize()
        
        
        if hasStarted {
            MainTabView()
                .environmentObject(viewRouter)
                .environmentObject(rdViewModel)
        } else {
            
            if isAuth {
                AuthView(hasStarted: $hasStarted)
            } else {
                
                // Auth OFF
                MainTabView()
                    .environmentObject(viewRouter)
                    .environmentObject(rdViewModel)
            }
        }
    }

}


