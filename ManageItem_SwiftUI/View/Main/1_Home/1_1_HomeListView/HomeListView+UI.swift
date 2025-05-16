//
//  HomeListView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI
import SFSafeSymbols

extension HomeListView {
    
    // Item List View
    var itemListView: some View {
        return ScrollView {
            LazyVStack(spacing: 12) {
                
                // - Branch
                if UserDefaults.standard.bool(forKey: "Verified") {
                    // [ Auth ]
                    if self.filteredItems.isEmpty {
                        self.emptyItemView
                    } else {
                        self.existItemView
                    }
                    
                } else {
                    
                    // [ No Auth ]
//                    if self.noAuthData.models.isEmpty {
                    if self.noAuthfilteredItems.isEmpty {
                        self.emptyItemView
                    } else {
                        self.noAuthExistItemView
                    }
                    
                }
                
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
    }
    
     
    
    
     // Item X
    var emptyItemView: some View {
        return VStack {
            Spacer().frame(height: 200)
            Text("검색 결과가 없어요 😨")
                .foregroundColor(.primary)
                .font(.title2)
                .padding()
            Spacer()
        }
    }
    
    
    
    // MARK: [ Auth ] - Item O
    var existItemView: some View {
        return ForEach(filteredItems.indices, id: \.self) { index in
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
                    
                    // 🔹 우측: name, partName, S/N
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
                    alertMessage = "장비명: \(item.name)\n부품명: \(item.partName)\nS/N: \(item.partNumber)\n위치: \(item.location)"
                    showAlert = true
                }
                .alert("정보", isPresented: $showAlert) {
                    Button("편집") {
                        let delivery = [item.name, item.partName, item.partNumber, item.location]
                        viewRouter.navigateMain(to: .add(title: "편집하기",
                                                         receiveLabels: delivery,
                                                         noAuth: nil
                                                        ))
                    }
                    Button("취소", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }
                .contextMenu {
                    Button(action: {
                        let delivery = [item.name, item.partName, item.partNumber, item.location]
                        viewRouter.navigateMain(to: .add(title: "편집하기",
                                                         receiveLabels: delivery,
                                                         noAuth: nil
                                                        ))
                    }) {
                        Label("편집", systemSymbol: .pencilLine)
                    }
                    
                    Button(action: {
                        UIPasteboard.general.string = "\(item.name), \(item.partNumber), \(item.partNumber), \(item.location)"
                    }) {
                        Label("복사", systemSymbol: .listBulletClipboard)
                    }
                    
                    Button(role: .destructive, action: {
                        
                        self.deleteId = item.id
        
                        alertMessageD = "정말로 삭제하시겠습니까?\n\n장비명: \(item.name)\n부품명: \(item.partName)\nS/N: \(item.partNumber)\n위치: \(item.location)"
                        self.showAlertD = true
                       
                    }) {
                        Label("삭제", systemSymbol: .arrowUpTrash)
                    }
                }
                .alert("확인", isPresented: $showAlertD) {
                    Button("삭제", role: .destructive) {
                        
                        if let deleteId = self.deleteId {
                            rdViewModel.deleteItem(withId: deleteId)
                        }
                    }
                    Button("취소", role: .cancel) {}
                } message: {
                    Text(alertMessageD)
                }
                
                // 🔸 마지막 셀 제외하고 Divider 추가
                if index < filteredItems.count - 1 {
                    Divider()
                        .background(Color.gray.opacity(0.3))
                }
            }
        }
    }
     
    
    
    
    // MARK: [ No Auth ] - Item O
    var noAuthExistItemView: some View {
        return ForEach(noAuthfilteredItems, id: \.id) { model in
           
            let location = model.location ?? ""
            let name = model.name ?? ""
            let partName = model.partName ?? ""
            let sn = model.serialNumber ?? ""
            
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 12) {
                    // 🔹 좌측: location
                    Text(location)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.screenWidth * 0.2,
                               height: UIScreen.screenWidth * 0.2)
                        .background(Color.gray)
                        .cornerRadius(8)
                    
                    // 🔹 우측: name, partName, S/N
                    VStack(alignment: .leading, spacing: 6) {
                        Text(name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(partName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(sn)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .frame(minHeight: 100)
                .padding(.vertical, 16)
                .contentShape(Rectangle())
                .onTapGesture {
                    
                    alertMessage = "이름: \(name)\n상세이름: \(partName)\n번호: \(sn)\n위치: \(location)"
                    showAlert = true
                }
                .contextMenu {
                    Button(action: {
                        let delivery = [name, partName, sn, location]
                        let _ = print("롱탭 = \(delivery)")
                        viewRouter.navigateMain(to: .add(title: "편집하기",
                                                         receiveLabels: delivery,
                                                         noAuth: model.id))
                    }) {
                        Label("편집", systemSymbol: .pencilLine)
                    }
                    
                    Button(action: {
                        let _ = print("복사 = \([name, partName, sn, location])")
                        UIPasteboard.general.string = "\([name, partName, sn, location])"
                    }) {
                        Label("복사", systemSymbol: .listBulletClipboard)
                    }
                    
                    Button(role: .destructive, action: {
                        self.deleteUUID = model.id
                        
                        alertMessageD = "정말로 삭제하시겠습니까?\n\n이름: \(name)\n상세이름: \(partName)\n번호: \(sn)\n위치: \(location)"
                        self.showAlertD = true
                       
                    }) {
                        Label("삭제", systemSymbol: .arrowUpTrash)
                    }
                }
                .alert("확인", isPresented: $showAlertD) {
                    Button("삭제", role: .destructive) {
                        if let id = deleteUUID {
                            if let realModel = noAuthData.models.first(where: { $0.id == id }) {
                                noAuthData.delete(model: realModel)
                            }
                        }
                    }
                    
                    Button("취소", role: .cancel) {}
                } message: {
                    Text(alertMessageD)
                }
                
                Divider()
                    .background(Color.gray.opacity(0.3))
            }
            
        }
        
    }
}
