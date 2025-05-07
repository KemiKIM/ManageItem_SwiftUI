//
//  HomeStartView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/4/25.
// 

import SwiftUI

struct HomeStartView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var inputText: String = ""
    
    @State var reload: Bool = false
}
    

