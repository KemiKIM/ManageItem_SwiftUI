//
//  AuthView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/2/25.
//

import SwiftUI

extension AuthView {
    var body: some View {
            // MARK:  >> [ ZStack ]
            ZStack {
                self.backgroundView
                
                VStack {
                    self.inputTextField
                    self.experienceBtn
                }
                 
            }  // MARK:  << [ ZStack ]
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                self.onAppear_AuthView()
            }
            .alert(
                "알림",
                isPresented: $showAlert,
                actions: { Button("확인") {} },
                message: { Text(alertMessage) }
            )
    }
}
