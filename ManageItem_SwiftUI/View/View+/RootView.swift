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
            EmptyView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .auth:
                        AuthView()
                    case .main:
                        MainView()
                    case .add:
                        AddView()
                    case .setting:
                        SettingView()
                    case .experience:
                        ExperienceView()
                    }
                }
                .onAppear {
                    
                    // Init = AuthView
                    if viewRouter.path.isEmpty {
                        viewRouter.navigate(to: .auth)
                    }
                }
        }
    }
}

