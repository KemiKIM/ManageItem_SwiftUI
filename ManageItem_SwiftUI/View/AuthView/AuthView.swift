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
    
    // TextField
    @State var inputText: String = ""
    
    // Alert
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    // Auth Number
    @State var authCode: String = ""
    @State var version: String = ""
    
    // iPhone Screen Size
    let width: CGFloat = UIScreen.screenWidth
    let height: CGFloat = UIScreen.screenHeight
    
    
    // Test Super AuthCode
    let superCode: String = "01012341234"
    
    
    
    
    
    
    
    // MARK: [ Function ]
    func onAppear_AuthView() {
        // 추후 활성화
//        self.rdViewModel.fetchCheckData {
//            MANGO.debug(self.rdViewModel.checkModel)
//            
//            // 1. Check Update
//            guard let version = self.rdViewModel.checkModel?.version else {
//                // Error 처리
//                return
//            }
//            self.version = version
//            self.checkUpdate {
//                
//                
//                
//                // 2. Check Auth
//        self.checkSavedAuth()
//            }
//        }

    }
    
    
    func checkUpdate(completion: @escaping () -> Void) {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            
            MANGO.info("Current Server Version = \(version)")
            MANGO.info("Current App Version    = \(appVersion)")
            
            if self.version > appVersion {
                MANGO.error("업데이트 필요!")
                // Alert 후 AppStore로 이동 Logic 필요.
                return
            } else {
                completion()
            }
        }
    }
    
    
    func checkSavedAuth() {
        guard let authCode = self.rdViewModel.checkModel?.auth_code else {
            // Error 처리
            return
        }
        
        // 1. 최초 진입
        if UserDefaults.standard.string(forKey: "SavedAuthCode") == nil {
            UserDefaults.standard.set(authCode, forKey: "SavedAuthCode")
            self.authCode = authCode
        } else {
            // 2. 서버 인증 번호와 앱 내 저장된 인증번호 비교
            if let savedAuthCode = UserDefaults.standard.string(forKey: "SavedAuthCode") {
                if savedAuthCode == authCode {
                    
                    // 인증 O
                    if UserDefaults.standard.bool(forKey: "Auth") {
                        viewRouter.navigate(to: .main)
                        return
                    }
                    
                } else {
                    // 인증번호가 변경됨.
                    
                    return
                }
            }
        }
        
       
        

    }
    
    
    
    
    
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
//            if inputText == self.authCode {
            if inputText == self.superCode {
                
                viewRouter.navigate(to: .main)
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    alertMessage = "유효하지 않은 인증번호입니다."
                    showAlert = true
                }
            }
            
            // (3)-2. init TextField
            self.inputText = ""
        }
    }
    
    
    

}




