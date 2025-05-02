//
//  SettingView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/30/25.
//

import SwiftUI

extension SettingView {
    
    // MARK: 1. Chagne Search Btn
    var changeSearchBtn: some View {
        Button(action: {
            // 1. completion
            self.changeSearchAndAdd(title: "search")
            
        }) {
            
            // 2. Set
            Text("검색 버튼으로 변경")
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
        }
        .background(Color.white)
        .frame(width: UIScreen.screenWidth * 0.9,
               height: UIScreen.screenHeight * 0.1)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(searchBorder, lineWidth: 2)
        )
        
    }
    
    
    
    // MARK: 2. Change Add Btn
    var changeAddBtn: some View {
        Button(action: {
            // 1. completion
            self.changeSearchAndAdd(title: "add")
            
        }) {
            // 2. Set
            Text("추가 버튼으로 변경")
                .padding(.leading, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
        }
        .background(Color.white)
        .frame(width: UIScreen.screenWidth * 0.9,
               height: UIScreen.screenHeight * 0.1)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(addBorder, lineWidth: 2)
        )
        
    }
    
    
    
    
    
    // MARK: 3. Set Auth Toggle
    var setAuthToggle: some View {
        Toggle("인증화면", isOn: $isAuth)
            .padding()
            .frame(width: UIScreen.screenWidth * 0.9,
                   height: UIScreen.screenHeight * 0.1)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.lightPink, lineWidth: 2)
            )
            .tint(.lightPink)
            .onChange(of: isAuth) { _, value in
                self.changeAuth(value)
            }
    }

    
    // MARK: 4. Move To Change AppIcon View
    var changeIconBtn: some View {
        Button(action: {
            // 1. completion
            withAnimation {
                showChangeAppIconView = true
                backgroundOpacity = 0.9
            }
            
        }) {
            // 2. Set
            Text("아이콘 변경하기")
                .padding()
                .foregroundColor(.black)
            
        }
        .frame(width: UIScreen.screenWidth * 0.9,
               height: UIScreen.screenHeight * 0.08)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.lightPink, lineWidth: 2)
        )
    }
    
    
    // MARK: 5. View Change AppIcon View
    var viewChangeAppIconView: some View {
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

    
    
    
}
