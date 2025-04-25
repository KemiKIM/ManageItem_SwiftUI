//
//  AddView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/24/25.
//

import SwiftUI

struct AddView: View {
    
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
            }
            .padding()
            .onAppear() {
                BamYangGang.info("View Add View")
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    
}
