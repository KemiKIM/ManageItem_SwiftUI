//
//  MainView+TabBar.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/4/25.
//

import SwiftUI
import SFSafeSymbols

extension MainTabView {
    
    var tabBar: some View {
        HStack {
            Spacer()
            
            
            Button {
                self.selectedAndVibrate(selected: .a)
                
                tapCount += 1
                tapTimer?.invalidate() // 기존 타이머 무효화
                
              
                // 새 타이머 시작
                tapTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    if tapCount >= 2 {
                        viewRouter.mainPath = NavigationPath()
                    }
                    tapCount = 0 // 초기화
                }
                
                
            } label: {
                VStack(alignment: .center) {
                    Image(systemSymbol: .house)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .a {
                        Text("홈")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .a ? Color.mSignature : Color.primary)
            
            
            
            
            Spacer()
            
            
            
            
            
            Button {
                self.selectedAndVibrate(selected: .b)

                
                
                tapCount += 1
                tapTimer?.invalidate() // 기존 타이머 무효화
                
              
                // 새 타이머 시작
                tapTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    if tapCount >= 2 {
                        viewRouter.zonePath = NavigationPath()
                    }
                    tapCount = 0 // 초기화
                }
            } label: {
                VStack(alignment: .center) {
                    Image(systemSymbol: .gearshiftLayoutSixspeed)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .b {
                        Text("배치도")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .b ? Color.mSignature : Color.primary)
            
            
            
            
            
            Spacer()
            
            
            
            
            
            Button {
                self.selectedAndVibrate(selected: .c)
                
                tapCount += 1
                tapTimer?.invalidate() // 기존 타이머 무효화
                
              
                // 새 타이머 시작
                tapTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                    if tapCount >= 2 {
                        viewRouter.settingPath = NavigationPath()
                    }
                    tapCount = 0 // 초기화
                }
                
            } label: {
                VStack(alignment: .center) {
                    Image(systemSymbol: .gearBadge)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .c {
                        Text("설정")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .c ? Color.mSignature : Color.primary)
            
            Spacer()
        }
       
        .padding()
        .frame(height: 72)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.adaptiveBackground)
                      .shadow(color: Color.tabbarShadow, radius: 8, y: 2)
        }
        .padding(.horizontal)
        
    }
}

