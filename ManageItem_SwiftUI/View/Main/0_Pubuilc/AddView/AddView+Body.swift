//
//  AddView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/30/25.
//

import SwiftUI

extension AddView {
    var body: some View {
        // MARK:  >> [ ScrollView + Lazy ]
        ScrollView {
            LazyVStack() {
                Spacer().frame(height: UIScreen.main.bounds.height * 0.2)
                
               
                HStack() {
                    self.setLeftLabels
                    self.setRightTextFields
                }
               
                Spacer().frame(height: UIScreen.main.bounds.height * 0.25)
                
                
                
                self.addBtn
            }
           
           
            .padding()
            .onAppear() {
                self.onAppear_AddView()
            }
            .ignoresSafeArea() // SafeArea 위아래
            .onTapGesture {
                UIApplication.shared.downKeyboard()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) { // 키보드 바로 위 툴바
                    Spacer()
                    Button(action: {
                        UIApplication.shared.downKeyboard()
                    }) {
                        Image(systemSymbol: .keyboardChevronCompactDown)
                            .foregroundColor(Color.mSignature)
                    }
                }
            }
            .alert(
                "알림",
                isPresented: $showAlert,
                actions: {
                    Button("취소") { }
                    Button("확인") {
        
                        if title == "추가하기" {
                            self.add {
                                viewRouter.popSetting()
                            } failure: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.alertMessage = ("체험하기에서는 최대 5개까지 추가할 수 있습니다.\n관리자에게 문의해주세요")
                                    self.errorAlert = true
                                }
                            }

                        } else {
                            self.edit {
                                viewRouter.popMain()
                            }
                        }
                    }
                },
                message: {
                    Text(alertMessage)
                }
            )
            .alert(
                "알림",
                isPresented: $errorAlert,
                actions: {
                    Button("확인") {
                        viewRouter.popSetting()
                    }
                },
                message: {
                    Text(alertMessage)
                }
            )
        }
        .background(Color.adaptiveBackground
            .ignoresSafeArea()
        )
        .navigationTitle(title)  // 타이틀 설정
        .navigationBarTitleDisplayMode(.inline)  // 타이틀 위치 설정
        .navigationBarBackButtonHidden(true)  // 기본 뒤로가기 버튼 숨기기
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if title == "추가하기" {
                        viewRouter.popSetting()
                    } else {
                        viewRouter.popMain()
                    }
                }) {
                    Image(systemSymbol: .chevronBackward)
                        .foregroundColor(Color.mSignature)
                }
            }
        }
    }
}
