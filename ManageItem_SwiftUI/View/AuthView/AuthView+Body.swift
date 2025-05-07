//
//  AuthView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/2/25.
//

import SwiftUI

extension AuthView {
    var body: some View {
            ZStack {
//                self.backgroundView
                AdaptiveBackgroundView()
                
                VStack {
//                    self.inputTextField
                    InputTextField(inputText: $inputText, placeholder: "인증번호를 입력하세요")
                        .keyboardType(.numberPad)
                        .onChange(of: inputText) { _, value in
                            self.checkNumberCondition(value: value)
                        }
                    self.experienceBtn
                }
                 
            }
            .onAppear() {
                self.onAppear_AuthView()
            }
            .ignoresSafeArea(.keyboard)
            .alert("알림",
                   isPresented: $showAlert,
                   actions: {
                        Button("확인") {}
                    },
                   message: { Text(alertMessage) }
            )
    }
    
    
}
