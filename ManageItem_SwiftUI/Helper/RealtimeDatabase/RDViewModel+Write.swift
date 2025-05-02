//
//  RDViewModel+Write.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import Foundation
import FirebaseDatabase

extension RDViewModel {
    
    // MARK: - 쓰기 (set)
    func setItem(withId id: String, data: [String: Any]) {
        self.isLoading = true
        
        ref.child("users").child(id).setValue(data) { error, _ in
            self.isLoading = false
            
            DispatchQueue.main.async {
                if let error = error {
                    self.writeStatusMessage = "쓰기 실패: \(error.localizedDescription)"
                    MANGO.error("쓰기 실패: \(error.localizedDescription)")
                } else {
                    self.writeStatusMessage = "쓰기 성공"
                    MANGO.info("쓰기 성공")
                }
            }
        }
        
       
    }

    // MARK: - 업데이트
    func updateItem(arrayIndex: Int, name: String, partName: String, partNumber: String, location: String) {
        self.isLoading = true
        
        let updateData: [String: Any] = [
            "name": name,
            "partName": partName,
            "partNumber": partNumber,
            "location": location
        ]

        ref.child("/allitems").updateChildValues(updateData) { error, _ in
            self.isLoading = false
            
            DispatchQueue.main.async {
                if let error = error {
                    self.writeStatusMessage = "업데이트 실패: \(error.localizedDescription)"
                    MANGO.error("업데이트 실패: \(error.localizedDescription)")
                } else {
                    self.writeStatusMessage = "업데이트 성공"
                    MANGO.debug("업데이트 성공")
                }
            }
        }
    
    }
}
