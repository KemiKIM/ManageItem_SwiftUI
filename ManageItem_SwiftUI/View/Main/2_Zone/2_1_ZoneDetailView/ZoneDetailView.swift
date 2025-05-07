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
        case "A": return "test"
        case "B": return "test"
        case "C": return "test"
        case "D": return "test"
        case "E": return "test"
        default: return "test"
        }
    }
}
