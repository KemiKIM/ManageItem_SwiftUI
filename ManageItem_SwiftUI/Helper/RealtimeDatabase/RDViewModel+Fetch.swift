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
    func fetchCheckData(completion: @escaping () -> Void) {
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
        
            
            
            // Check Data 추출
            // 1. Version
            guard let version = value["version"] as? String else {
                self.errorMessage = "version error"
                print("version error")
                return
            }
            
            // 2. Auth Code
            guard let authCode = value["auth_code"] as? String else {
                self.errorMessage = "auth_code error"
                print("auth_code error")
                return
            }
            
            let checkData = CheckModel(version: version, auth_code: authCode)
            self.checkModel = checkData
            completion()
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
