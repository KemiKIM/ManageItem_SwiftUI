//
//  UISearchBar.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/25/25.
//

import SwiftUI
import UIKit

struct SearchBarWrapper: UIViewRepresentable {
    @Binding var text: String
    var searchBarRef: Binding<UISearchBar?>

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "검색하세요"
        
        // ✅ 키보드 툴바 추가
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            image: UIImage(systemSymbol: .keyboardChevronCompactDown), // SF Symbol 이름
            style: .done,
            target: context.coordinator,
            action: #selector(context.coordinator.dismissKeyboard)
        )
        doneButton.tintColor = .defaultColor
        
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




