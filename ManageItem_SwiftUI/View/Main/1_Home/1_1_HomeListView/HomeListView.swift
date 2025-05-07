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
    @EnvironmentObject var rdViewModel: RDViewModel
    
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
    
   

}
