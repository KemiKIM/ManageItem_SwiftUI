//
//  ZoneListView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/27/25.
//

import SwiftUI
import SFSafeSymbols

struct ZoneListView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    let zones = ["A", "B", "C", "D", "E", "F", "G", "CABINET"]
    

    
    
    
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
    
}
