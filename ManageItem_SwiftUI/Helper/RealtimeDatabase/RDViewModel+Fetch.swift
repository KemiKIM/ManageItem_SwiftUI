//
//  RDViewModel+Fetch.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import Foundation
import FirebaseDatabase

extension RDViewModel {
    
    // MARK: fetch - Check
    func fetchCheckData() {
        self.isLoading = true
        
        
        ref.child("/check").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                self.isLoading = false
                
                DispatchQueue.main.async {
                    self.errorMessage = "버전 정보가 존재하지 않음"
                }
                return
            }
            
            self.isLoading = false
        
            
            
            // 서버 버전 정보 추출
            if let version = value["iOS_Version"] as? String {
                let checkData = CheckModel(iOS_Version: version)
                
                DispatchQueue.main.async {
                    self.checkModel = checkData
                    
                    if let extractedVersion = self.checkModel?.iOS_Version.replacingOccurrences(of: "\"", with: "") {
                        UserDefaults.standard.set(extractedVersion, forKey: "server_iOS_version")
                    }
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.errorMessage = "버전 정보 형식이 잘못되었습니다."
                }
            }
            
        }
    }
    
    
    
    // MARK: fetch - allitems
    func fetchAllItems() {
        ref.child("/allitems").observeSingleEvent(of: .value) { snapshot in
            // Loading Start
            self.isLoading = true
            
            var fetchedItems: [ItemModel] = []
            
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let value = snap.value as? [String: Any],
                   let name = value["name"] as? String,
                   let partName = value["partName"] as? String,
                   let partNumber = value["partNumber"] as? String,
                   let location = value["location"] as? String {
                    
                    let item = ItemModel(
                        id: snap.key,
                        name: name,
                        partName: partName,
                        partNumber: partNumber,
                        location: location
                    )
                    fetchedItems.append(item)
                }
            }
            
            self.isLoading = false
            
            DispatchQueue.main.async {
                self.items = fetchedItems
            }
            
        }
    }
}
