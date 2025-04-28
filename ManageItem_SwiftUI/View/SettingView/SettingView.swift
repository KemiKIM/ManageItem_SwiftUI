//
//  SettingView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI
import PopupView

struct SettingView: View {
    
    
    // 0. Toast
    @State var showToast: Bool = false
    @State var toastMessge = ""
    
    
    // 1. Search or Add
    @State private var isSearchTapped = UserDefaults.standard.bool(forKey: "State_Search")
    @State private var isAddTapped = UserDefaults.standard.bool(forKey: "State_Add")
    @State private var searchBorder: Color = UserDefaults.standard.bool(forKey: "State_Search") ? Color.green : Color(UIColor.systemGray5)
    @State private var addBorder: Color = UserDefaults.standard.bool(forKey: "State_Add") ? Color.green : Color(UIColor.systemGray5)

    
    // 2. Auth
    @State private var isAuth: Bool = UserDefaults.standard.bool(forKey: "Auth")
    
    
    // 3. Change Icon
    @State private var backgroundOpacity: Double = 1.0
    @State private var showChangeAppIconView = false
    
    
    
    
    
    
    
    
    // MARK: [ Body ]
    var body: some View {
        
        
        // MARK:  >> [ Geometry + ZStack ]
        GeometryReader { geometry in
            ZStack {
                
                
                // MARK: > [ VStack ]
                VStack(alignment: .leading, spacing: 20) {
                    // Text
                    Text("여기는 테스트")
                        .padding()
                    
                    
                    // 1. Search Btn
                    Button(action: {
                        self.searchBtnTapped()
                    }) {
                        Text("검색 버튼")
                            .padding()
                            .foregroundColor(.blue)
                    }
                    .background(Color.white)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.08)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(searchBorder, lineWidth: 3)
                    )
                    
                    
                    // 2. Add Btn
                    Button(action: {
                        self.addBtnTapped()
                    }) {
                        Text("추가 버튼")
                            .padding()
                            .foregroundColor(.blue) // 글자 색상인 듯
                    }
                    .background(Color.white)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.08)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(addBorder, lineWidth: 3)
                    )
                    
                    
                    
                    // 3. Auth Toggle
                    Toggle("인증관련", isOn: $isAuth)
                        .padding()
                        .tint(.lightPink)
                        .onChange(of: isAuth) { _, value in
                            self.changeAuth(value)
                        }
                    
                    
                    
                    
                    // 4. Change Icon
                    Button(action: {
                        withAnimation {
                            showChangeAppIconView = true
                            backgroundOpacity = 0.9
                        }
                    }) {
                        Text("아이콘 변경 버튼")
                            .padding()
                            .foregroundColor(.blue)
                    }
                    .background(Color.white)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.08)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 3)
                    )
                }
                .onAppear() {
                    BamYangGang.info("View SettingView")
                    
                    if isSearchTapped == isAddTapped {
                        UserDefaults.standard.set(true, forKey: "State_Search")
                    }
                }
                .padding()
                .opacity(showChangeAppIconView ? backgroundOpacity : 1.0) // 새로운 뷰가 나타날 때 기존 뷰의 알파값을 0.3으로 설정
                .disabled(showChangeAppIconView) // 새로운 뷰가 나타나면 기존 뷰는 비활성화
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top) // Required Geometry
                // MARK: < [ VStack ]
                
                
                
                
                
                // MARK: > [ ChangeIcon View ]
                if showChangeAppIconView {
                    VStack {
                        Spacer()
                        ChangeAppIconView(showChangeAppIconView: $showChangeAppIconView)
                            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.2)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .transition(.move(edge: .bottom))
                            .onTapGesture {} // [⭐️] 새로운 뷰 탭했을 때 아무작동이 없도록
                    }
                    .background(Color.black.opacity(0.8)) // 새로운 뷰 뒤의 화면 어두운 배경
                    .edgesIgnoringSafeArea(.all) // 화면의 모든 영역을 차지하게 함
                    .onTapGesture {
                        withAnimation {
                            showChangeAppIconView = false
                            backgroundOpacity = 1.0
                        }
                    }
                }
                // MARK: < [ ChangeIcon View ]
            }
            .animation(.easeInOut, value: showChangeAppIconView)
            .popup(isPresented: $showToast) {
                ToastView(text: toastMessge)
            } customize: {
                $0
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring())
                    .autohideIn(1.0)
            }
        }
        // MARK:  << [ Geometry + ZStack ]
    }
    
    
    
    
    // MARK: [ Function ]
    func searchBtnTapped() {
        isSearchTapped = true
        isAddTapped = false
        searchBorder = Color.green
        addBorder = Color(UIColor.systemGray5)
        
        
        // 상태를 UserDefaults에 저장
        UserDefaults.standard.set(true, forKey: "State_Search")
        UserDefaults.standard.set(false, forKey: "State_Add")
    }
    
    func addBtnTapped() {
        isSearchTapped = false
        isAddTapped = true
        searchBorder = Color(UIColor.systemGray5)
        addBorder = Color.green
        
        
        // 상태를 UserDefaults에 저장
        UserDefaults.standard.set(false, forKey: "State_Search")
        UserDefaults.standard.set(true, forKey: "State_Add")
    }
    
        
    
    // Change [ Auth ]
    func changeAuth(_ toggle: Bool) {
        // Default: OFF
        
        if toggle { // ON
            UserDefaults.standard.set(true, forKey: "Auth")
            self.toastMessge = "인증 설정 완료"
            
        } else {    // OFF
            UserDefaults.standard.set(false, forKey: "Auth")
            self.toastMessge = "인증 해제 완료"
        }
        
        // Toast
        DispatchQueue.main.async {
            print("-->", self.toastMessge)
            self.showToast = true
        }
        
    }

}




