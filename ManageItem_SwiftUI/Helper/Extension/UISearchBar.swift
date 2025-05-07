//
//  UISearchBar.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/25/25.
//

import SwiftUI
import UIKit
import SFSafeSymbols

struct SearchBarWrapper: UIViewRepresentable {
    @Binding var text: String
    var searchBarRef: Binding<UISearchBar?>

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "검색하세요"
        

        
        
        // 🔹 기본 배경 제거
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .clear
        searchBar.backgroundColor = .clear

        // 🔹 전체 바깥 배경색 처리
        if let backgroundView = searchBar.subviews.first?.subviews.first {
            backgroundView.backgroundColor = UIColor(Color.adaptiveBackground) // 원하는 색상으로
            backgroundView.layer.cornerRadius = 10
            backgroundView.clipsToBounds = true
        }

        // 🔹 텍스트필드 색상
        let textField = searchBar.searchTextField
        textField.backgroundColor = UIColor(Color.mBackground)
        textField.textColor = .black
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(Color.adaptiveBackground.opacity(0.8)).cgColor
        textField.clipsToBounds = true
        
        
        
        // ✅ 키보드 툴바 추가
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            image: UIImage(systemSymbol: .keyboardChevronCompactDown), // SF Symbol 이름
            style: .done,
            target: context.coordinator,
            action: #selector(context.coordinator.dismissKeyboard)
        )
        doneButton.tintColor = UIColor(Color.mSignature)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexible, doneButton]
        
        searchBar.inputAccessoryView = toolbar

        // ⛳️ 상태 변경은 안전하게 큐에 넘기기
        DispatchQueue.main.async {
            searchBarRef.wrappedValue = searchBar
        }

        return searchBar
    }



    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        let parent: SearchBarWrapper
        init(_ parent: SearchBarWrapper) {
            self.parent = parent
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.text = searchText
        }
        
        @objc func dismissKeyboard() {
            parent.searchBarRef.wrappedValue?.resignFirstResponder()
        }
    }
}




