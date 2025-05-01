//
//  ToastView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/28/25.
//

import SwiftUI

struct ToastView: View {
    let text: String
    
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .font(.headline)
                .padding(.vertical, 10)
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}
