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
    @State var noAuth: UUID?  // id를 받아옴
    @State var receiveLabels: [String]  // labels를 받아옴
    
    // [ Auth ]
    @EnvironmentObject var rdViewModel: RDViewModel
    
    // [ No Auth ]
    @StateObject var noAuthData = NoAuthDataVM()
    
    // TextField
    var labels = ["장비명", "부품명", "S/N", "위치"]
    @State var inputValues: [String] = Array(repeating: "", count: 4)
    
    // Alert
    @State var showAlert = false
    @State var errorAlert = false
    @State var alertMessage = ""
    
    
    // MARK: [ Function ]
    func onAppear_AddView() {
        MANGO.info("View Add View \(width), \(height)")
        
        if self.receiveLabels != [] {
            self.inputValues = self.receiveLabels
        }
    }
    // name: String, location: String, partName: String: 
    func add(success: @escaping () -> Void, failure: @escaping () -> Void) {
        // - Branch
        if UserDefaults.standard.bool(forKey: "Verified") {
            
            // [ Auth ]
            
        } else {
            
            // [ No Auth ]
            if self.noAuthData.totalCount >= 5 {
                failure()
            } else {
                self.noAuthData.add(name: self.inputValues[0],
                                    partName: self.inputValues[1],
                                    serialNumber: self.inputValues[2],
                                    location: self.inputValues[3])
                success()
            }
        }
        
    
    }
    
    func edit(completion: @escaping () -> Void) {
        // - Branch
        if UserDefaults.standard.bool(forKey: "Verified") {
            
            // [ Auth ]
            
        } else {
            
            // [ No Auth ]
            self.noAuthData.update(someId: noAuth!,
                                   newName: self.inputValues[0],
                                   newLocation: self.inputValues[1],
                                   newPartName: self.inputValues[2],
                                   newSerialNumber: self.inputValues[3])
        }
        
        completion()
    }
    
}
