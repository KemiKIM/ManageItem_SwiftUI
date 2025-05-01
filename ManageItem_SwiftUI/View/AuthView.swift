//
//  AuthView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    // TextField
    @State var inputText = ""

    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    
    // iPhone Screen Size
    let width = UIScreen.screenWidth
    let height = UIScreen.screenHeight
   
    
    
    
    
    // MARK: [ Body ]
    var body: some View {
        
        
            // MARK:  >> [ ZStack ]
            ZStack {
                Color(UIColor.systemGray2)
                    .ignoresSafeArea() // SafeArea 위아래
                    .onTapGesture {
                        UIApplication.shared.downKeyboard()
                    }
                
                // MARK: > [ VStack ]
                VStack {
                 
                    
                    // VStack: 1. TextField
                    TextField("숫자를 입력하세요", text: $inputText)
                        .keyboardType(.numberPad)
                        .padding(.leading, 10)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) { // 키보드 바로 위 툴바
                                Spacer()
                                Button("완료") {
                                    UIApplication.shared.downKeyboard()
                                }
                            }
                        }
                        .onChange(of: inputText) { _, value in
                            self.checkNumberCondition(value: value)
                        }
                    // End: VStack: TextField
                    
                    
                    
                    
                    // VStack: 2. Btn
                    Button("체험해보기") {
                        viewRouter.navigate(to: .main)
//                        viewRouter.navigate(to: .experience)
                    }
                    .foregroundStyle(Color(UIColor.black))
                    .background(Color(UIColor.systemPink))
                    // End: VStack: Btn
                    
                    
                    
                } // MARK: < [ VStack ]
                .padding()
                .alert(
                    "알림",
                    isPresented: $showAlert,
                    actions: { Button("확인") {} },
                    message: { Text(alertMessage) }
                )
                
                
                
            }  // MARK:  << [ ZStack ]
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                BamYangGang.debug("-> Auth View \(width), \(height)")
                
                // 인증 O
//                if UserDefaults.standard.bool(forKey: "Auth") {
//                    viewRouter.navigate(to: .main)
//                }
            }
    }
        
    
    
    
    // MARK: [ Function ]
    // Check Number Condition
    func checkNumberCondition(value: String) {
        // (1). Only Number
        let filtered = value.filter { $0.isNumber }
        
        
        // (2). Maximum 11
        if filtered.count > 11 {
            inputText = String(filtered.prefix(11))
        } else {
            inputText = filtered
        }
        
        
        // (3). Check Number 11
        if inputText.count == 11 {
            UIApplication.shared.downKeyboard()
            
            // (3)-1. Condition check
            if inputText == "01012341234" { // Super Number
                viewRouter.navigate(to: .main)
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    alertMessage = "유효한 전화번호 형식이 아닙니다. (010-XXXX-XXXX)"
                    showAlert = true
                }
            }
            
            // (3)-2. init TextField
            self.inputText = ""
        }
    }
    
    
    

}




