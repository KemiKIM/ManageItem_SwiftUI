//
//  ZoneListView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/27/25.
//

import SwiftUI
import SFSafeSymbols
import PhotosUI

struct ZoneListView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    // [ Auth ]
    let zones = ["A", "B", "C", "D", "E", "F", "G", "CABINET"]
    
    
    // [ No Auth ]
    @StateObject var noAuthImage = NoAuthImageVM()
    
    @State var imagePaths: [String] = []
    @State var selectedItem: PhotosPickerItem?
    @State var showAlert = false
    @State var shouldOpenPicker = false

    
    
    
    
    // [ Auth ] - List
    func returnIcon(zone: String) -> SFSymbol {
        switch zone {
        case "A": return .aSquare
        case "B": return .bSquare
        case "C": return .cSquare
        case "D": return .dSquare
        case "E": return .eSquare
        case "F": return .fSquare
        case "G": return .gSquare
        default: return .cSquareFill
        }
    }
    
    
    // [ No Auth ] - Save Image
    func saveImageToDocuments(image: UIImage) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let filename = UUID().uuidString + ".jpg"
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return url
        } catch {
            print("이미지 저장 실패: \(error)")
            return nil
        }
    }
}
