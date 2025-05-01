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
        
    @State private var searchText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    @State var showAlert = false
    @State var alertMessage = ""
    
    @State private var isSearchActive: Bool = false
    
    @State private var searchBar: UISearchBar? = nil
    
    // iPhone Screen Size
    let width = UIScreen.screenWidth
    let height = UIScreen.screenHeight
    
    
    
    var customBtn: String = UserDefaults.standard.string(forKey: "customBtn") ?? "search"
    
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

    
    var body: some View {
            // >> ZStack
            ZStack {
                Color(UIColor.white).ignoresSafeArea() // background Color
                
                
                // >> VStack
                VStack(spacing: 0) {
                    // UIKit SearchBar
                    SearchBarWrapper(text: $searchText, searchBarRef: $searchBar)
                        .padding(.horizontal)
                    
                    
                    // ✅ 고정 헤더
                    self.headerView
                    
                    
                    // ✅ 데이터 리스트
                    itemListView
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 1).onChanged { _ in
                            UIApplication.shared.downKeyboard()
                        }
                    )
                    .refreshable {
                        self.rdViewModel.fetchAllItems()
                    }
                    .tint(Color(UIColor.red))
                } // << VStack
                
                
                self.customButton
                
  
            } // << ZStack
            .onAppear() {
                
                BamYangGang.info("View MainView \(width), \(height)")
//                self.rdViewModel.fetchCheckData()
                self.rdViewModel.fetchAllItems()
                
                
            }
            .onDisappear() { }
            .withGlobalLoadingView($rdViewModel.isLoading)  // 로딩 화면 추가
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Main View")
            .navigationBarItems(
                leading: Button(action: {
                    // AddView로 네비게이션
                    viewRouter.navigate(to: .setting)
                }) {
                    Image(systemSymbol: .gearshape2Fill)
                        .foregroundColor(.blue)
                },
                trailing: Button(action: {
                    // AddView로 네비게이션
                    viewRouter.navigate(to: .add(title: "추가하기", receiveLabels: []))
                }) {
                    Image(systemSymbol: .plusDiamond)
                        .foregroundColor(.red)
                }
            )
            .ignoresSafeArea(.keyboard)

    }
    
    
    
    
    // MARK: [ Header ]
    
    private var headerView: some View {
        HStack {
            Text("장비명").frame(maxWidth: .infinity, alignment: .leading)
            Text("파트명").frame(maxWidth: .infinity, alignment: .leading)
            Text("파트번호").frame(maxWidth: .infinity, alignment: .leading)
            Text("위치").frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .font(.headline)
        .frame(height: 40)
        .background(Color.blue.edgesIgnoringSafeArea([]))
    }
    
    
    
    
    private var customButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    print("Button tapped")
                    // Handle button action
                }) {
                    Image(systemSymbol: (customBtn == "search") ? .magnifyingglass : .plusBubble)
                        .font(.system(size: 55)) // 버튼 크기 조정
                        .foregroundColor(.blue)
                        .background(Color.white)
                }
                .padding(.bottom, 60)
                .padding(.trailing, 20)
            }
        }
    }
    
    private var itemListView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if filteredItems.isEmpty {
                    VStack {
                        Spacer()
                        Text("검색 결과 없음")
                            .foregroundColor(.black)
                            .font(.title3)
                            .padding()
                        Spacer()
                    }
                } else {
                    ForEach(filteredItems) { item in
                        HStack(spacing: 0) {
                            Text(item.name)
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            ZStack {
                                Color.gray
                                Text(item.partName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10)
                            }
                            
                            Text(item.partNumber)
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            ZStack {
                                Color.gray
                                Text(item.location)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10)
                            }
                        }
                        .overlay(Rectangle().frame(height: 0.5).foregroundColor(.gray), alignment: .bottom)
                        .alert("알림", isPresented: $showAlert, presenting: alertMessage, actions: { _ in
                            Button("편집") {
                                let delivery = ["\(item.name)", "\(item.partName)", "\(item.partNumber)", "\(item.location)"]
                                viewRouter.navigate(to: .add(title: "편집하기", receiveLabels: delivery))
                            }
                            Button("취소", role: .cancel) {}
                        }, message: { message in
                            Text(message)
                        })
                        .onTapGesture {
                            alertMessage = "이름: \(item.name)\n부품명: \(item.partName)\n부품번호: \(item.partNumber)\n위치: \(item.location)"
                            showAlert = true
                        }
                    }
                }
            }
        }
    }

    // MARK: [ Function ]
    // Check App Version
    func checkUpdate(completion: @escaping () -> Void) {
        
        if let serverVersion = UserDefaults.standard.string(forKey: "server_iOS_version") {
            if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
             
                BamYangGang.info("serverVersion = \(serverVersion)")
                BamYangGang.info("appVersion = \(appVersion)")
                
                
                if serverVersion > appVersion {
                    BamYangGang.error("업데이트 필요!")
                    
                } else {
                    completion()
                }
                
            }
        } else {
            // 추출 불가
            completion()
        }
        
    }
    
    
    func handleButtonAction() {
        if customBtn == "plus" {
        
            // plus
            DispatchQueue.main.async {
                viewRouter.navigate(to: .add(title: "추가하기", receiveLabels: []))
            }
           

            
        } else {
            // search
            searchBar?.becomeFirstResponder()
        }
    }
    
    
    
    
}
