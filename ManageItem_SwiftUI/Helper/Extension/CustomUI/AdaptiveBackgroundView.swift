//
//  AdaptiveBackgroundView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI

struct AdaptiveBackgroundView: View {
    var body: some View {
        Color.adaptiveBackground
            .ignoresSafeArea()
            .onTapGesture {
                UIApplication.shared.downKeyboard()
            }
    }
}
