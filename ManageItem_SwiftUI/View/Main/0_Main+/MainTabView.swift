//
//  MainView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI
import SFSafeSymbols

struct MainTabView: View {
    enum Tab { // Tag에서 사용할 Tab 열겨형
          case a, b, c
      }
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var selected: Tab = .a
    @State var lastSelected: Tab = .a

    
    @StateObject var tabBarState = MainTabBarState()
    
    
    
    @State var tapCount = 0
    @State var tapTimer: Timer?
    
    
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selected) {
                Group {
                
                    // 홈
                    NavigationStack(path: $viewRouter.mainPath) {
                        HomeStartView()
                            .navigationDestination(for: MainScreen.self) { screen in
                                switch screen {
                                case .start:
                                    HomeStartView()
                                case .home(let searchText):
                                    HomeView(searchText: searchText ?? "")
                                case .add(let title, let receiveLabels):
                                    AddView(title: title, receiveLabels: receiveLabels)
                                }
                            }
                        
                     
                    }
                    .tag(Tab.a)
                    .environmentObject(tabBarState)
                    
                    
                    // 배치도
                    NavigationStack(path: $viewRouter.zonePath) {
                        ConfirmZoneView()
                            .navigationDestination(for: ZoneScreen.self) { screen in
                                switch screen {
                                case .imagezone(let zone):
                                    ImageZoneView(zone: zone)
                                }
                            }
                    }
                    .tag(Tab.b)
                    
                    
                    // 설정
                    NavigationStack(path: $viewRouter.settingPath) {
                        SettingView()
                            .navigationDestination(for: SettingScreen.self) { screen in
                                switch screen {
                                case .add(let title, let receiveLabels):
                                    AddView(title: title, receiveLabels: receiveLabels)
                                }
                            }
                    }
                    .tag(Tab.c)
                }
                .toolbarBackground(.hidden, for: .tabBar)
            }

            
            VStack {
                Spacer()
//                tabBar
                if !tabBarState.isHidden {
                    tabBar
                }
            }
          
            
        }
        .ignoresSafeArea(.keyboard)
        .environmentObject(tabBarState)
        
    }
    
    
    func selectedAndVibrate(selected: Tab) {
        self.selected = selected
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
}







