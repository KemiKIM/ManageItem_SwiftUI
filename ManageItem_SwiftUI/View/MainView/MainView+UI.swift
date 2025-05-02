//
//  MainView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/2/25.
//

import SwiftUI
import SFSafeSymbols

extension MainView {
    
    // MARK: 1. HeaderView
    var headerView: some View {
        HStack {
            ForEach(labels, id: \.self) { label in
                Text(label)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .font(.headline)
        .frame(height: 40)
        .background(Color.defaultColor.edgesIgnoringSafeArea([]))
    }

    
    
    
    // MARK: 2. List
    var itemListView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if filteredItems.isEmpty {
                    self.emptyView
                    
                } else {
                    ForEach(filteredItems) { item in
                        HStack(spacing: 0) {
                            self.setList(item.name)
                            self.setList(item.partName, background: Color.gray.opacity(0.2))
                            self.setList(item.partNumber)
                            self.setList(item.location, background: Color.gray.opacity(0.2))
                        }
                        .frame(height: 60)
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
    
    
    
    // MARK: 3. Bottom Custom Button
    var customButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.handleButtonAction()
                    
                }) {
                    Image(systemSymbol: (UserDefaults.standard.string(forKey: "CustomBtn") == "search") ? .magnifyingglassCircle : .plusCircle)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45) // 아이콘 크기
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.defaultColor)
                        .clipShape(.circle)
                }
                .padding(.bottom, 60)
                .padding(.trailing, 20)
            }
        }
    }
}
