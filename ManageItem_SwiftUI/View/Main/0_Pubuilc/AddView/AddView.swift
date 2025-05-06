//
//  AddView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/24/25.
//

import SwiftUI
import SFSafeSymbols

struct AddView: View {
    
    // iPhone Screen Size
    let width = UIScreen.screenWidth
    let height = UIScreen.screenHeight
    
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var title: String  // 타이틀을 받아옴
    @State var receiveLabels: [String]  // labels를 받아옴
    
    // TextField
    let labels = ["장비명", "부품명", "S/N", "위치"]
    @State var inputValues: [String] = Array(repeating: "", count: 4)
    
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    
    // MARK: [ Function ]
    func onAppear_AddView() {
        MANGO.info("View Add View \(width), \(height)")
        
        
        if self.receiveLabels != [] {
            self.inputValues = self.receiveLabels
        }
    }
    
}
