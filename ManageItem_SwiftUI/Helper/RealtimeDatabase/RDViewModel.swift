//
//  RDViewModel.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import Foundation
import FirebaseDatabase
import Combine

class RDViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @Published var checkModel: CheckModel? = nil
    
    @Published var isLoading: Bool = false
    
    @Published var errorMessage: String? = nil
    @Published var writeStatusMessage: String? = nil

    let ref = Database.database().reference()
}
