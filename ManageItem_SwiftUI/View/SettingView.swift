//
//  SettingView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI

struct SettingView: View {
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    @State private var searchBar: UISearchBar? = nil

    
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            Button("검색 버튼으로 변경") {
                UserDefaults.standard.set("search", forKey: "customBtn")
            }
            
            Button("추가 버튼으로 변경") {
                UserDefaults.standard.set("plus", forKey: "customBtn")
            }
            
            
            Button("기본 아이콘으로 변경") {
                changeAppIcon(to: nil)
            }
            
            Button("AppIcon1로 변경") {
                changeAppIcon(to: "AppIcon1")
            }

//            Button("AppIcon2로 변경") {
//                changeAppIcon(to: "AppIcon2")
//            }
        }
        .padding()
        .onAppear() {
            BamYangGang.info("View SettingView")
        }
    }
    
    
    // 18.4.1 AppIcon 수정 불가로 나오는데 뭔질 모르겠음.
    func changeAppIcon(to name: String?) {
        guard UIApplication.shared.supportsAlternateIcons else {
            print("이 디바이스는 아이콘 변경을 지원하지 않음")
            return
        }

        DispatchQueue.main.async {
            UIApplication.shared.setAlternateIconName(name) { error in
                if let error = error {
                    print("아이콘 변경 실패: \(error.localizedDescription)")
                } else {
                    print("아이콘 변경 성공")
                }
            }
        }
 
    }
    
    
}
