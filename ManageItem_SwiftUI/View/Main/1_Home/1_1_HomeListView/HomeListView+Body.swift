//
//  HomeListView+Body.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI
import SFSafeSymbols

extension HomeListView {
    
    var body: some View {
        
        ZStack {
            Color.mBackground // systemBackground는 다크 모드에서 진한 검정
                .ignoresSafeArea()
//            Color.white
            
            VStack(spacing: 0) {
                SearchBarWrapper(text: $searchText, searchBarRef: $searchBar)
                    .padding(.horizontal)
                
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
            }
            .onAppear() {
                
//                self.rdViewModel.fetchAllItems()
            }
            .withGlobalLoadingView($rdViewModel.isLoading)  // 로딩 화면 추가
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("검색")
            .ignoresSafeArea(.keyboard)
            .navigationBarItems(
                leading: Button(action: {
                   
                    viewRouter.popMain()
                    
                }) {
                    Image(systemSymbol: .chevronBackward)
                        .foregroundColor(.mSignature)
                }
            )
        }
    }
}
