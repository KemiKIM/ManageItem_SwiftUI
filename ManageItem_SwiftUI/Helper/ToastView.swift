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
            if text == "" {
              let _ = print("text가 아직 들어오지 않았음.")
            }
            Text(text)
                .font(.headline)
                .padding(.vertical, 10)
            Spacer()
        }
        .background(Color.black.opacity(0.1))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}
