//
//  ZoneDetailView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/3/25.
//

import SwiftUI

struct ZoneDetailView: View  {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var tabBarState: MainTabBarState
    
    let zone: String
    
    @State var scale: CGFloat = 1.0
    @State var lastScale: CGFloat = 1.0
    @State var offset: CGSize = .zero
    @State var lastOffset: CGSize = .zero
    

    
    // - Branch
    func returnImage(zone: String) -> Image {
        if UserDefaults.standard.bool(forKey: "Verified") {
            
            // [ Auth ] - assets saved Image
            switch zone {
            case "A", "B": return Image("Zone_A_B")
            case "C": return Image("Zone_C")
            case "D": return Image("Zone_D")
            case "E": return Image("Zone_E")
            case "F": return Image("Zone_F")
            case "G": return Image("Zone_G")
            default:
                return Image("Zone_CABINET")
            }
        } else {
            
            // [ No Auth ] - Gallery
            let url = URL(fileURLWithPath: zone)
            if FileManager.default.fileExists(atPath: url.path),
               let data = try? Data(contentsOf: url),
               let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            } else {
                return Image(systemName: "photo")
            }
        }
    }
}
