//
//  AuthView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var rdViewModel: RDViewModel
    
    @State var inputText = ""

    @State var showAlert = false
    @State var alertMessage = ""
    
    
    
    // MARK: [ Body ]
    
    
    var body: some View {
        
            // MARK:  >> [ ZStack ]
            ZStack {
                Color(UIColor.systemGray2)
                    .ignoresSafeArea() // SafeArea위로
                    .onTapGesture {
                        UIApplication.shared.downKeyboard()
                    }
                
                // MARK: > [ VStack ]
                VStack {
                 
                    
                    // VStack: TextField
                    TextField("숫자를 입력하세요", text: $inputText)
                        .keyboardType(.numberPad) // 숫자 키보드 설정
                        .padding(.leading, 10)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding()
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
                    
                    
                    
                    
                    // VStack: Btn
                    Button("Go to Main View") {
                        UserDefaults.standard.set(false, forKey: "Auth")
                        viewRouter.navigate(to: .main)
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
                BamYangGang.debug("-> Auth View")
                
                
                // 추후 작업
//                self.rdViewModel.fetchCheckData()
//                self.checkUpdate {
//                    if UserDefaults.standard.bool(forKey: "Auth") {
//                        viewRouter.navigate(to: .main)
//                    }
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
    
    
    

    // Check App Version
    func checkUpdate(completion: @escaping () -> Void) {
        
        if let serverVersion = UserDefaults.standard.string(forKey: "server_iOS_version") {
            if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
             
                BamYangGang.info("serverVersion = \(serverVersion)")
                BamYangGang.info("appVersion = \(appVersion)")
                
                
                if serverVersion > appVersion {
                    BamYangGang.error("업데이트 필요!")
                    
                } else {
                    completion()
                }
                
            }
        } else {
            // 추출 불가
            completion()
        }
        
    }
    
   
    

}




