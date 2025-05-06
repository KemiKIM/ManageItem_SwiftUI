//
//  HomeView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/4/25.
//

import SwiftUI
import SFSafeSymbols

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var rdViewModel: RDViewModel
    
    // 검색어 받아옴
    @State var searchBar: UISearchBar? = nil
    @State var searchText: String
    
    let labels: [String] = ["장비명", "파트명", "S/N", "위치"]
    
    // Alert
    @State var showAlert = false
    @State var alertMessage = ""
    
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
    
   
    var itemListView: some View {
        return ScrollView {
            LazyVStack(spacing: 12) {
                if filteredItems.isEmpty {
                    self.emptyView
                } else {
                    ForEach(filteredItems.indices, id: \.self) { index in
                        let item = filteredItems[index]

                        VStack(spacing: 0) {
                            HStack(alignment: .top, spacing: 12) {
                                // 🔹 좌측: location
                                Text(item.location)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.screenWidth * 0.2,
                                           height: UIScreen.screenWidth * 0.2)
                                    .background(Color.gray)
                                    .cornerRadius(8)

                                // 🔹 우측: name, partName, partNumber
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text(item.partName)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)

                                    Text(item.partNumber)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                Spacer()
                            }
                            .frame(minHeight: 100)
                            .padding(.vertical, 16)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                alertMessage = "이름: \(item.name)\n부품명: \(item.partName)\n부품번호: \(item.partNumber)\n위치: \(item.location)"
                                showAlert = true
                            }
                            .alert("알림", isPresented: $showAlert) {
                                Button("편집") {
                                    let delivery = [item.name, item.partName, item.partNumber, item.location]
                                    viewRouter.navigateMain(to: .add(title: "편집하기", receiveLabels: delivery))
                                }
                                Button("취소", role: .cancel) {}
                            } message: {
                                Text(alertMessage)
                            }

                            // 🔸 마지막 셀 제외하고 Divider 추가
                            if index < filteredItems.count - 1 {
                                Divider()
                                    .background(Color.gray.opacity(0.3))
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
    }
    
    
    // Item X
    var emptyView: some View {
        VStack {
            Spacer().frame(height: 200)
            Text("검색 결과가 없어요 😨")
                .foregroundColor(.black)
                .font(.title2)
                .padding()
            Spacer()
        }
    }
    
    // Item O
    @ViewBuilder
    func setList(_ text: String, background: Color? = nil) -> some View {
        if let bg = background {
            ZStack {
                bg
                Text(text)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
            }
        } else {
            Text(text)
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
        }
    }
    var body: some View {
        
        ZStack {
            Color.customColor // systemBackground는 다크 모드에서 진한 검정
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
//                self.rdViewModel.fetchCheckData()
//                self.rdViewModel.fetchAllItems()
            }
            .withGlobalLoadingView($rdViewModel.isLoading)  // 로딩 화면 추가
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("자재관리")
            .ignoresSafeArea(.keyboard)
            .navigationBarItems(
                leading: Button(action: {
                   
                    viewRouter.popMain()
                    
                }) {
                    Image(systemSymbol: .chevronBackward)
                        .foregroundColor(.defaultColor)
                }
            )
        }
    }
}
