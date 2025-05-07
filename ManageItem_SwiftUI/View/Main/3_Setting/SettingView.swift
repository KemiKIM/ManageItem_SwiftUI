//
//  SettingView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI
import PopupView

struct SettingView: View {
    @AppStorage("appColorMode") var appColorMode: AppColorMode = .system
    
    @EnvironmentObject var viewRouter: ViewRouter

    
    // 1. Auth
    @State var hasStarted: Bool = UserDefaults.standard.bool(forKey: "hasStarted")
    
    @State var isAgendaExpanded = false
}




