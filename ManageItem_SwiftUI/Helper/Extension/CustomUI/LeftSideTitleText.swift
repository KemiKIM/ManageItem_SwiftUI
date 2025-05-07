//
//  LeftSideTitleText.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI

struct LeftSideTitleText: View {
    var title: String
    
    var body: some View {
        
        Text(title)
            .padding(.leading, 30)
            .font(.title)
            .fontWeight(.bold)
        
    }
}
