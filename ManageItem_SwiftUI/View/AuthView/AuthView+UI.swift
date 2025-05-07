//
//  AuthView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/2/25.
//

import SwiftUI
import SFSafeSymbols

extension AuthView {
    // MARK: 1. Background View
//    var backgroundView: some View {
//        Color.cardBackground
//            .ignoresSafeArea() // SafeArea 위아래
//            .onTapGesture {
//                UIApplication.shared.downKeyboard()
//            }
//    }
    
    // MARK: 2. Input TextField
//    var inputTextField: some View {
//        TextField("인증번호를 입력하세요", text: $inputText)
//            .keyboardType(.numberPad)
//            .padding(.leading, 10)
//            .frame(width: UIScreen.screenWidth * 0.8, height: 50)
//            .background(Color.black.opacity(0.1))
//            .cornerRadius(10)
//            .toolbar {
//                ToolbarItemGroup(placement: .keyboard) { // 키보드 바로 위 툴바
//                    Spacer()
//                    Button(action: {
//                        UIApplication.shared.downKeyboard()
//                    }) {
//                        Image(systemSymbol: .keyboardChevronCompactDown)
//                            .foregroundColor(Color.defaultColor)
//                    }
//
//                }
//            }
//            .onChange(of: inputText) { _, value in
//                self.checkNumberCondition(value: value)
//            }
//           
//    }
    
    // MARK: 3. Experience Btn
    var experienceBtn: some View {
        
            Button(action: {
                
                hasStarted = true
                UserDefaults.standard.set(false, forKey: "Verified")
                
            }) {
                Text("체험해보기")
                    .underline()
                    .foregroundStyle(Color.mSignature)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: UIScreen.screenWidth * 0.5,
                   height: UIScreen.screenHeight * 0.05
            )
    }

    
}
