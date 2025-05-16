//
//  HomeView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/4/25.
//

import SwiftUI
import SFSafeSymbols

struct HomeListView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    // [ Auth ]
    @EnvironmentObject var rdViewModel: RDViewModel
    
    // [ No Auth ]
    @StateObject var noAuthData = NoAuthDataVM()
    @State var deleteUUID: UUID? = nil
    
    
    // 검색어 받아옴
    @State var searchBar: UISearchBar? = nil
    @State var searchText: String
    
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    // Delete Alert
    @State var showAlertD = false
    @State var alertMessageD = ""
    @State var deleteId: String? = nil
    
    
    
    
    // [ Auth ]
    var filteredItems: [ItemModel] {
        if searchText.isEmpty {
            return rdViewModel.items
        } else {
            return rdViewModel.items.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.partName.localizedCaseInsensitiveContains(searchText) ||
                $0.partNumber.localizedCaseInsensitiveContains(searchText) ||
                $0.location.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    
    // [ No Auth ]
    var noAuthfilteredItems: [NoAuthData] {
        if searchText.isEmpty {
            return self.noAuthData.models
        } else {
            return self.noAuthData.models.filter {
                let name = $0.name ?? ""
                let partName = $0.partName ?? ""
                let sn = $0.serialNumber ?? ""
                let location = $0.location ?? ""
                
                return name.localizedCaseInsensitiveContains(searchText) ||
                partName.localizedCaseInsensitiveContains(searchText) ||
                sn.localizedCaseInsensitiveContains(searchText) ||
                location.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
   

}
