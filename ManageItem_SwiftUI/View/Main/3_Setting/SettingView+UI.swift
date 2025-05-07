//
//  SettingView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/30/25.
//

import SwiftUI

extension SettingView {
    
    // Section 1
    var versionBtn: some View {
        return Button {
            
        } label: {
            HStack {
                Text("version")
                    .foregroundColor(Color.primary)
                Spacer()
                Text("1.0.2")
                    .foregroundColor(.primary)
                
            }
        }
    }

    // Section 2-1
    var authToggle: some View {
        return Toggle("인증화면 활성화", isOn: $hasStarted)
            .onChange(of: hasStarted) { _, newValue in
                print("기능 A: \(newValue)")
//                                self.changeAuth(newValue)
                
                if hasStarted {
                    // ON
                    UserDefaults.standard.set(true, forKey: "hasStarted")
                } else {
                    // OFF
                    UserDefaults.standard.set(false, forKey: "hasStarted")
                }
           
                
            }
            .tint(Color.mSignature)
    }
    
    // Section 2-2
    var changeModeBtn: some View {
        return   Button {
            withAnimation {
                isAgendaExpanded.toggle()
            }
        } label: {
            HStack {
                Text("모드 설정")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemSymbol: isAgendaExpanded ? .chevronDownCircle : .chevronRightCircle)
                    .foregroundColor(.primary)
            }
        }
        
    }
    
    // Section 2-2-1
    var changeModeListBtn: some View {
        return ForEach(AppColorMode.allCases) { mode in
            Button {
                appColorMode = mode
                applyAppColorMode(mode)
            } label: {
                HStack {
                    Text(mode.description)
                        .foregroundColor(.primary)
                    Spacer()
                    if appColorMode == mode {
                        Image(systemSymbol: .checkmarkCircle)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.leading, 24) // 선택지 들여쓰기
            }
        }
    }
    
    
    
    // Section 3
    var addBtn: some View {
        return Button {
            // 이동
            viewRouter.navigateSetting(to: .add(title: "추가하기", receiveLabels: []))
        } label: {
            HStack {
                Text("추가하기")
                    .foregroundColor(.primary)
                Spacer()
                Image(systemSymbol: .plusCircle)
                    .foregroundColor(.primary)
            }
        }
    }
    
}
