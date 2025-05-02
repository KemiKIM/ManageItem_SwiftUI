//
//  SettingView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI
import PopupView

struct SettingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    // iPhone Screen Size
    let width = UIScreen.screenWidth
    let height = UIScreen.screenHeight
    
    // 0. Toast
    @State var showToast: Bool = false
    @State var toastMessge = ""
    
    
    // 1. Search or Add
//    @State var isSearchTapped = UserDefaults.standard.bool(forKey: "State_Search")
//    @State var isAddTapped = UserDefaults.standard.bool(forKey: "State_Add")
    @State var searchBorder: Color = Color(UIColor.systemGray5)
    @State var addBorder: Color = Color(UIColor.systemGray5)

    
    // 2. Auth
    @State var isAuth: Bool = UserDefaults.standard.bool(forKey: "Auth")
    
    
    // 3. Change Icon
    @State var backgroundOpacity: Double = 1.0
    @State var showChangeAppIconView = false
    
    
    
    

    

    
    
    
    
    // MARK: [ Function ]
    
//    func searchBtnTapped() {
//        isSearchTapped = true
//        isAddTapped = false
//        searchBorder = Color.green
//        addBorder = Color(UIColor.systemGray5)
//        
//        
//        // 상태를 UserDefaults에 저장
//        UserDefaults.standard.set(true, forKey: "State_Search")
//        UserDefaults.standard.set(false, forKey: "State_Add")
//        UserDefaults.standard.set("search", forKey: "CustomBtn")
//    }
//    
//    func addBtnTapped() {
//        isSearchTapped = false
//        isAddTapped = true
//        searchBorder = Color(UIColor.systemGray5)
//        addBorder = Color.green
//        
//        
//        // 상태를 UserDefaults에 저장
//        UserDefaults.standard.set(false, forKey: "State_Search")
//        UserDefaults.standard.set(true, forKey: "State_Add")
//        UserDefaults.standard.set("plus", forKey: "CustomBtn")
//    }
    
    func onAppear_SettingView() {
        if UserDefaults.standard.string(forKey: "CustomBtn") == nil {
            self.searchBorder = Color.green
        } else {
            if let customBtn = UserDefaults.standard.string(forKey: "CustomBtn") {
                if customBtn == "search" {
                    searchBorder = Color.green
                    addBorder = Color(UIColor.systemGray5)
                } else {
                    searchBorder = Color(UIColor.systemGray5)
                    addBorder = Color.green
                }
            }
        }
    }
    
    
    func changeSearchAndAdd(title: String) {
        if title == "search" {
            UserDefaults.standard.set("search", forKey: "CustomBtn")
            searchBorder = Color.green
            addBorder = Color(UIColor.systemGray5)
            
        } else {
            UserDefaults.standard.set("add", forKey: "CustomBtn")
            searchBorder = Color(UIColor.systemGray5)
            addBorder = Color.green
        }
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
        
        // View Toast
        DispatchQueue.main.async {
            self.showToast = true
        }
        
    }

}




