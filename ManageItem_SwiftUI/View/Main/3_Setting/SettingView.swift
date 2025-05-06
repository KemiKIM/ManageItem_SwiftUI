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

    
    // 0. Toast
    @State var showToast: Bool = false
    @State var toastMessge = ""
    
    
    // 1. Search or Add
    @State var searchBorder: Color = Color(UIColor.systemGray5)
    @State var addBorder: Color = Color(UIColor.systemGray5)

    
    // 2. Auth
    @State var hasStarted: Bool = UserDefaults.standard.bool(forKey: "hasStarted")
    

    

    
    @AppStorage("appColorMode") var appColorMode: AppColorMode = .system

    
    @State var isAgendaExpanded = false
    
  
    
    
}




