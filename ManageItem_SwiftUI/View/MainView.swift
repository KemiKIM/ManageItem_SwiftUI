//
//  MainView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/22/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var rdViewModel: RDViewModel
    
    @State private var searchText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    @State var showAlert = false
    @State var alertMessage = ""
    
    @State private var isSearchActive: Bool = false
    
    @State private var searchBar: UISearchBar? = nil
    
    
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
                    
                    
                    
                    
                    // ✅ 데이터 리스트
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
                                               Color.gray // 셀 높이에 맞게 배경 입히기
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
                                               Color.gray // 셀 높이에 맞게 배경 입히기
                                               Text(item.location)
                                                   .frame(maxWidth: .infinity, alignment: .leading)
                                                   .lineLimit(2)
                                                   .multilineTextAlignment(.leading)
                                                   .padding(.leading, 10)
                                           }
                                        
                                    }
                                    .overlay(
                                        Rectangle()
                                            .frame(height: 0.5)
                                            .foregroundColor(.gray),
                                        alignment: .bottom
                                    )
                                    .alert("알림", isPresented: $showAlert, presenting: alertMessage, actions: { _ in
                                     
                                        Button("편집") {
                                            print("편집 버튼 클릭됨")
                                            
                                            viewRouter.navigate(to: .add)
          
                                       
                                        }
                                        Button("취소", role: .cancel) {
                                            print("취소 버튼 클릭됨")
                                        }
                                    }, message: { message in // message 클로저
                                        Text(message) // 동적으로 전달된 alertMessage
                                    })
                                    .onTapGesture {
                                        print("Tapped item: \(item)")
                                        alertMessage = "이름: \(item.name)\n부품명: \(item.partName)\n부품번호: \(item.partNumber)\n위치: \(item.location)"
                                        
                                        showAlert = true
                                    }
                                  
                                    
                                    
                                }
                            }
                        }
                    }
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
                
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // 버튼 액션
                            print("Button tapped")
                            handleButtonAction()
                        }) {
                            Image(systemName: customBtn == "search" ? "magnifyingglass" : "plus")
                                .font(.system(size: 55)) // 버튼 크기 조정
                                .foregroundColor(.blue)
                                .background(Color.white)
                        }
                        .padding(.bottom, 60) // 하단 여백111
                        .padding(.trailing, 20) // 우측 여백
                    }
                }
                
  
            } // << ZStack
            .onAppear() {
                BamYangGang.info("View MainView")
//                self.rdViewModel.fetchCheckData()
                self.rdViewModel.fetchAllItems()
                
            }
            .onDisappear() { }
            .withGlobalLoadingView($rdViewModel.isLoading)  // 로딩 화면 추가
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Main View")
            .navigationBarItems(
                leading: NavigationLink(destination: SettingView(), label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.blue)
                }),
                trailing: NavigationLink(destination: AddView(), label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.red)
                })
            )
            .ignoresSafeArea(.keyboard)

    }
    
    
    
    
    func handleButtonAction() {
        if customBtn == "plus" {
        
            // plus
            DispatchQueue.main.async {
                viewRouter.navigate(to: .add)
            }
           

            
        } else {
            // search
            searchBar?.becomeFirstResponder()
        }
    }
    
    
}
