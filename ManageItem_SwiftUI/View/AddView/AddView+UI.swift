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
            Text("추가하기")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.white)
               
        }
        .background(Color.defaultColor)
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width * 0.9,
               height: UIScreen.main.bounds.height * 0.05
        )
    }
}

