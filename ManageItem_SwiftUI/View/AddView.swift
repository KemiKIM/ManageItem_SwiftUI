//
//  AddView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/24/25.
//

import SwiftUI
import SFSafeSymbols

struct AddView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var title: String  // 타이틀을 받아옴
    @State var receiveLabels: [String]  // labels를 받아옴
    
    // TextField
    let labels = ["장비명", "부품명", "파트번호", "위치"]
    @State var inputValues: [String] = Array(repeating: "", count: 4)
    
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
  
    
    var body: some View {
        
        // MARK:  >> [ ScrollView + ZStack ]
        ScrollView {
            LazyVStack() {
                Spacer().frame(height: UIScreen.main.bounds.height * 0.2)
                
                
                
                
                HStack() {
                    
                    VStack() {
                        ForEach(labels, id: \.self) { text in
                            Text("\(text):")
                                .frame(width: UIScreen.main.bounds.width * 0.2,
                                       height: UIScreen.main.bounds.height * 0.05,
                                       alignment: .leading
                                )
                        }
                        
                    }
                    
                    
                    VStack() {
                        ForEach(labels.indices, id: \.self) { index in
                            TextField(labels[index], text: $inputValues[index])
                                .padding(.leading, 10)
                                .padding(.vertical, UIScreen.main.bounds.height * 0.05 * 0.2)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .frame(width: UIScreen.main.bounds.width * 0.7,
                                       height: UIScreen.main.bounds.height * 0.05
                                )
                        }
                    }
                   
                }
               
                
                
                
                Spacer().frame(height: UIScreen.main.bounds.height * 0.33)
                
                
                
                
                Button(action: {
                    showAlert = true
                    self.alertMessage = "\(inputValues)"
                    let _ = print("전달받은 값: \(inputValues)")
                    
                    
                    
                }) {
                    Text("추가하기")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.white)
                       
                }
                .background(Color.defaultColor)
                .cornerRadius(10)
                .frame(width: UIScreen.main.bounds.width * 0.9,
                       height: UIScreen.main.bounds.height * 0.05
                )
                // End: VStack: Btn
            }
            .background(.white)
            .padding()
            .onAppear() {
                BamYangGang.info("View Add View")
                
                
                if self.receiveLabels != [] {
                    self.inputValues = self.receiveLabels
                }
                
            }
            .ignoresSafeArea() // SafeArea 위아래
            .onTapGesture {
                UIApplication.shared.downKeyboard()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) { // 키보드 바로 위 툴바
                    Spacer()
                    Button("완료") {
                        UIApplication.shared.downKeyboard()
                    }
                }
            }
            .alert(
                "알림",
                isPresented: $showAlert,
                actions: {
                    Button("취소") { }
                    Button("확인") {
                        let _ = print("이곳입니다!", alertMessage)
                        // 1. 값을 RDB에 작성
                        
                        // 2. 뒤로 가기.
                        viewRouter.pop()
                    }
                },
                message: {
                    Text(alertMessage)
                }
            )
        }
        .navigationTitle(title)  // 타이틀 설정
        .navigationBarTitleDisplayMode(.inline)  // 타이틀 위치 설정
        .navigationBarBackButtonHidden(true)  // 기본 뒤로가기 버튼 숨기기
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // 뒤로가기 동작 구현
                    viewRouter.pop()  // 또는 self.presentationMode.wrappedValue.dismiss() 사용
                }) {
                    Image(systemSymbol: .arrowLeftToLine)  // 커스텀 뒤로가기 아이콘
                        .foregroundColor(Color.defaultColor)  // 뒤로가기 버튼 색상
                }
            }
        }
    }
    
    
    
}
