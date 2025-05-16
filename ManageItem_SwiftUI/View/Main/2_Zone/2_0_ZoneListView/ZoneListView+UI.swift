//
//  ZoneListView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI
import SFSafeSymbols
import PhotosUI

extension ZoneListView {
    
    // MARK: [ Auth ]
    var authList: some View {
        return List {
            
            ForEach(zones, id: \.self) { zone in
                
                Button(action: {
                    print("\(zone) 클릭됨")
                    DispatchQueue.main.async {
                        viewRouter.navigateZone(to: .detail(zone: zone))
                    }
                }) {
                    HStack {
                        Image(systemSymbol: returnIcon(zone: zone))
                            .foregroundColor(Color.primary)
                        Text("\(zone) 구역")
                            .font(.headline)
                            .foregroundColor(Color.primary)
                    }
                }
                
            }
        }
        .listStyle(.insetGrouped)
    }
    
    
    
    
    
    
    
    // MARK: [ No Auth ]
    var noAuthList: some View {
        return List {
            if !self.noAuthImage.models.isEmpty {
                Section() {
                    ForEach(noAuthImage.models, id: \.objectID) { model in
                        Button(action: {
                            DispatchQueue.main.async {
                                if let path = model.noAuthImage {
                                    viewRouter.navigateZone(to: .detail(zone: path))
                                } else {
                                    // error
                                }
                            }
                        }) {
                            HStack {
                                Image(systemSymbol: .bookPages)
                                    .foregroundColor(Color.primary)
                                Text("추가한 이미지")
                                    .font(.headline)
                                    .foregroundColor(Color.primary)
                            }
                        }
                    }
                    .onDelete(perform: noAuthImage.delete(at:))
                    
                }
            }

            // ✅ 일반 버튼으로 교체
            Section  {
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    HStack {
                        Image(systemSymbol: .plus)
                            .foregroundColor(Color.primary)
                        Text("추가하기")
                            .font(.headline)
                            .foregroundColor(Color.primary)
                    }
                    
                 
                }
            }
        }
        .listStyle(.insetGrouped)
        .alert("알림", isPresented: $showAlert) {
            Button("확인", role: .cancel) {
                 selectedItem = nil  // ✅ 갤러리 이전 선택 초기화
            }
        } message: {
            Text("체험하기에서는 최대 한 장까지 추가할 수 있습니다.\n관리자에게 문의해주세요")
        }
        // ✅ selectedItem 처리
        .onChange(of: selectedItem) { _, newItem in
            guard let newItem else { return }
            
            // Check Count - Alert
            if self.noAuthImage.totalCount >= 1 {
                showAlert = true
                return
            }
            
            // Add
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: data),
                   let savedURL = saveImageToDocuments(image: image) {
                    self.noAuthImage.add(path: savedURL.path)
                }
                selectedItem = nil
            }
        }
        // ✅ PhotosPicker를 programmatically 실행
        .onChange(of: shouldOpenPicker) { _, shouldOpen in
            if shouldOpen {
                DispatchQueue.main.async {
                    // trigger the hidden PhotosPicker
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                shouldOpenPicker = false
            }
        }
    }
    
}
