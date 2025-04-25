//
//  AuthView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI

struct AuthView: View {
    var onSuccess: () -> Void     // 로그인 성공 후 실행할 클로저

    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var rdViewModel: RDViewModel
    
    
    @State var inputText = ""
    
    
    
    
    @State var showAlert = false
    @State var alertMessage = ""
    
    
    
    
    
    var body: some View {
        
        NavigationStack {
            // >> ZStack : Background
            ZStack {
                Color(UIColor.systemGray2)
                    .ignoresSafeArea() // SafeArea위로
                    .onTapGesture {
                        UIApplication.shared.downKeyboard()
                    }
                
                // >> VStack
                VStack {
                 
                    // TextField
                    TextField("숫자를 입력하세요", text: $inputText)
                        .keyboardType(.numberPad) // 숫자 키보드 설정
                        .padding(.leading, 10)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding()
//                        .toolbar {
//                            ToolbarItemGroup(placement: .keyboard) { // 키보드 바로 위 툴바
//                                Spacer()
//                                Button("완료") {
//                                    UIApplication.shared.downKeyboard()
//                                }
//                            }
//                        }
                        .onChange(of: inputText) { newValue in
                            // 1. 숫자만 허용
                            let filtered = newValue.filter { $0.isNumber }

                            // 2. 최대 11자리 제한
                            if filtered.count > 11 {
                                inputText = String(filtered.prefix(11))
                            } else {
                                inputText = filtered
                            }

                            // 3. 11자리가 되었을 때 함수 실행
                            if inputText.count == 11 {
                                onNumberEnteredFully(number: inputText)
                            }
                        }
                    
                    
                    // Button
                    Button("Go to Main View") {
                        UserDefaults.standard.set(false, forKey: "Auth")
                        viewRouter.currentScreen = .main
                    }
                    .foregroundStyle(Color(UIColor.black))
                    .background(Color(UIColor.systemPink))
                    
                    
                    
                } // << VStack
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                }
                
                
            }  // << ZStack
            .ignoresSafeArea(.keyboard)
            .onAppear() {
                BamYangGang.info("View AuthView")
                
                self.rdViewModel.fetchCheckData()
                
                // 업데이트 로직 적용 필요.
                self.checkUpdate {
                    if UserDefaults.standard.bool(forKey: "Auth") {
                        onSuccess()
                    }
                }
            }
    
            
        }
        
        
    }
        
    
    
    func onNumberEnteredFully(number: String) {
        print("✅ 11자리 숫자 입력 완료됨! 함수 실행")
    
        
        UIApplication.shared.downKeyboard()
        self.inputText = ""
        
        print(number)
        
        
        // 조건 체크
        if number == "01012341234" {
            UserDefaults.standard.set(true, forKey: "Auth")
            onSuccess()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertMessage = "유효한 전화번호 형식이 아닙니다. (010-XXXX-XXXX)"
                showAlert = true
            }
        }
    }
    
    
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




