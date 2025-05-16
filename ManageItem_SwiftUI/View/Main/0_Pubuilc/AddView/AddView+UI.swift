//
//  AddView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/30/25.
//

import SwiftUI
import SFSafeSymbols

extension AddView {
    
    
    
    
    var setLeftLabels: some View {
        VStack() {
            ForEach(labels, id: \.self) { text in
                Text("\(text):")
                    .frame(width: UIScreen.main.bounds.width * 0.2,
                           height: UIScreen.main.bounds.height * 0.05,
                           alignment: .leading
                    )
                    .foregroundColor(.primary)
            }
            
        }
    }
    
    var setRightTextFields: some View {
        VStack() {
            ForEach(labels.indices, id: \.self) { index in
                TextField(labels[index], text: $inputValues[index])
                    .padding(.leading, 10)
                    .padding(.vertical, UIScreen.main.bounds.height * 0.05 * 0.2)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width * 0.7,
                           height: UIScreen.main.bounds.height * 0.05
                    )
            }
        }
    }
    
    
    
    // MARK: 0. Add/Fix Btn
    var addBtn: some View {
        Button(action: {
            showAlert = true
            self.alertMessage = "\(inputValues)"
            let _ = print("전달받은 값: \(inputValues)")
            
            
            
        }) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.white)
               
        }
        .background(Color.mSignature)
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width * 0.9,
               height: UIScreen.main.bounds.height * 0.05
        )
    }
}

