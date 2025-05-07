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
    
    
    // 이미지 수령 후 작업 필요
    func returnImage(zone: String) -> String {
        switch zone {
        case "A": return "Zone_A_B"
        case "B": return "Zone_A_B"
        case "C": return "Zone_C"
        case "D": return "Zone_D"
        case "E": return "Zone_E"
        case "F": return "Zone_F"
        case "G": return "Zone_G"
        default: return "Zone_CABINET"
        }
    }
}
