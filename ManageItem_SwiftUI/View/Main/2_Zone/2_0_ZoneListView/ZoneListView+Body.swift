//
//  ZoneListView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI

extension ZoneListView {
    var body: some View {
        ZStack {
            Color(Color.mBackground).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 60)
                
                LeftSideTitleText(title: "배치도")
                
                // - Branch
                if UserDefaults.standard.bool(forKey: "Verified") {
                    
                    // [ Auth ]
                    self.authList
                } else {
                    
                    // [ No Auth ]
                    self.noAuthList
                }
            }
            
        }
        
    }
}
