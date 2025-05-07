//
//  HomeStartView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI

extension HomeStartView {
    var body: some View {
        ZStack {
//            self.backgroundView
            AdaptiveBackgroundView()
            
            VStack {
                
                Spacer()
//                self.inputTextField
                InputTextField(inputText: $inputText, placeholder: "검색어를 입력하세요")
                    .submitLabel(.done)
                    .onSubmit {
                        UIApplication.shared.downKeyboard()
                        print("입력된 텍스트: \(inputText)")
                        viewRouter.navigateMain(to: .home(searchText: inputText))
                    }
                Spacer()

            }
        }
        .onAppear() {
            self.reload.toggle()
        }
        .onDisappear() {
            self.inputText = ""
        }
        .ignoresSafeArea(.keyboard)
    }
}
