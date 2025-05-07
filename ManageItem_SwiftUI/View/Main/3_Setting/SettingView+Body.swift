//
//  SettingView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/30/25.
//

import SwiftUI
import SFSafeSymbols

extension SettingView {
    
    var body: some View {
        
        ZStack {
            Color.mBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 60)
                
                LeftSideTitleText(title: "설정화면")
                
                
                List {
                    // (1)
                    Section {
                        self.versionBtn
                    }
                    
                    // (2)
                    Section {
                        self.authToggle
                        self.changeModeBtn
                        
                        if isAgendaExpanded {
                            self.changeModeListBtn
                        }
                    }
                    
                    // (3)
                    Section {
                        self.addBtn
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .background(Color.mBackground) // List 자체의 배경
                .listStyle(.insetGrouped)
                
            }
            
        }
    }
    
    
}

