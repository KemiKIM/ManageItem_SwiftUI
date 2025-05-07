//
//  InputTextField.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI
import SFSafeSymbols

struct InputTextField: View {
    @Binding var inputText: String
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $inputText)
            .padding(.leading, 10)
            .frame(width: UIScreen.screenWidth * 0.8, height: 50)
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(action: {
                        UIApplication.shared.downKeyboard()
                    }) {
                        Image(systemSymbol: .keyboardChevronCompactDown)
                            .foregroundColor(Color.mSignature)
                    }
                }
            }
        
    }
}
