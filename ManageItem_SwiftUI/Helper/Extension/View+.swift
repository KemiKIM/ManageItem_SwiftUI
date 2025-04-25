//
//  View+.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI
import Lottie

extension View {
    
    func withGlobalLoadingView(_ isLoading: Binding<Bool>) -> some View {
        ZStack {
            self
            if isLoading.wrappedValue {
                Color.black.opacity(0.3).ignoresSafeArea()
                ControllableLottieView(name: "dog", isPlaying: .constant(true))
                    .frame(width: 100, height: 100)
            }
        }
    }
    
}

