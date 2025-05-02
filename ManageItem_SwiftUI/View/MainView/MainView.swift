//
//  MainView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI
import SFSafeSymbols

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var rdViewModel: RDViewModel
        
    // Search Bar
    @State var searchBar: UISearchBar? = nil
    @State var searchText = ""
    
    // Labels
    let labels: [String] = ["장비명", "파트명", "파트번호", "위치"]
    
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
    // iPhone Screen Size
    let width = UIScreen.screenWidth
    let height = UIScreen.screenHeight
    
    @State var customBtn: String = UserDefaults.standard.string(forKey: "CustomBtn") ?? "search"
    
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

    

    
    
    
  
    // MARK: [ Function ]
    
    
    func handleButtonAction() {
        
        if let customBtn = UserDefaults.standard.string(forKey: "CustomBtn") {
            if customBtn == "add" {
                // add
                DispatchQueue.main.async {
                    viewRouter.navigate(to: .add(title: "추가하기", receiveLabels: []))
                }
            } else {
                // search
                searchBar?.becomeFirstResponder()
            }
        }
    }
    
    
}
