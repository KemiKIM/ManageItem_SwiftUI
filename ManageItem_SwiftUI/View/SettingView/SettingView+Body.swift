//
//  SettingView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/30/25.
//

import SwiftUI

extension SettingView {
    var body: some View {
        // MARK:  >>> [ Geometry ]
        GeometryReader { geometry in
            
            
            // MARK:  >> [ ZStack ]
            ZStack {
                
                
                // MARK: > [ VStack ]
                VStack(alignment: .leading, spacing: 20) {
                    // Text
                    Text("설정화면")
                        .padding(.leading, 10)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    
                    // 1. Change (Search Btn <-> Add Btn)
                    self.changeSearchBtn
                    self.changeAddBtn
                    
                    // 2. Set Auth Toggle
                    self.setAuthToggle
                    
                    // 3. Move to Change Icon View
                    self.changeIconBtn
                }
                .onAppear() {
                    MANGO.info("SettingView \(width), \(height)")
                    
                    self.onAppear_SettingView()
                }
                .padding()
                // 새로운 뷰가 나타날 때 기존 뷰의 알파값을 0.3으로 설정
                .opacity(showChangeAppIconView ? backgroundOpacity : 1.0)
                // 새로운 뷰가 나타나면 기존 뷰는 비활성화
                .disabled(showChangeAppIconView)
                // Required Geometry
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                // MARK: < [ VStack ]
                
                
                
                
                // MARK: Check ChangeAppIconView
                if showChangeAppIconView {
                    self.viewChangeAppIconView
                }
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
            // MARK: << [ ZStack ]
            
        }
        // 1. Background
        .background(.white)
        
        // 2. Navigation
        .navigationTitle("")  // 타이틀 설정
        .navigationBarTitleDisplayMode(.inline)  // 타이틀 위치 설정
        .navigationBarBackButtonHidden(true)
        
        // 3. Navigation Toolbar
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemSymbol: .chevronBackward)
                        .foregroundColor(Color.defaultColor)
                }
            }
        }
        // MARK:  <<< [ Geometry ]
    }
}
