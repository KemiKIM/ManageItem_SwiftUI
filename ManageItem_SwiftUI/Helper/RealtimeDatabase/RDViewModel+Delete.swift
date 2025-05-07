//
//  RDViewModel+Delete.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import Foundation
import FirebaseDatabase

extension RDViewModel {
    
    // MARK: - 삭제
    func deleteItem(withId id: String) {
        self.isLoading = true
        
        ref.child("/allitems").child(id).removeValue { error, _ in
            self.isLoading = false
            
            DispatchQueue.main.async {
                if let error = error {
                    self.writeStatusMessage = "삭제 실패: \(error.localizedDescription)"
                    MANGO.error("삭제 실패: \(error.localizedDescription)")
                } else {
                    self.writeStatusMessage = "삭제 성공"
                    MANGO.debug("삭제 성공")
                    
                    // 삭제된 후 items 리스트에서 해당 아이템도 제거
                    if let index = self.items.firstIndex(where: { $0.id == id }) {
                        self.items.remove(at: index)
                    }
                }
            }
        }
    }

}
