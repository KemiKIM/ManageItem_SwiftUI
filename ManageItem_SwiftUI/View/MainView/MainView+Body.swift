//
//  MainView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/2/25.
//

import SwiftUI

extension MainView {
    var body: some View {
            // >> ZStack
            ZStack {
                Color(UIColor.white).ignoresSafeArea() // background Color
                
                
                // >> VStack
                VStack(spacing: 0) {
                    // (UIKit) SearchBar
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
                MANGO.info("[ MainView ]")
//                self.rdViewModel.fetchCheckData()
//                self.rdViewModel.fetchAllItems()
                
                
            }
            .withGlobalLoadingView($rdViewModel.isLoading)  // 로딩 화면 추가
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("자재관리")
            .navigationBarItems(
                leading: Button(action: {
                    // AddView로 네비게이션
                    viewRouter.navigate(to: .setting)
                }) {
                    Image(systemSymbol: .gearshapeCircle)
                        .foregroundColor(.defaultColor)
                },
                trailing: Button(action: {
                    // AddView로 네비게이션
                    viewRouter.navigate(to: .add(title: "추가하기", receiveLabels: []))
                }) {
                    Image(systemSymbol: .plusCircle)
                        .foregroundColor(.lightPink)
                }
            )
            .ignoresSafeArea(.keyboard)

    }
}
