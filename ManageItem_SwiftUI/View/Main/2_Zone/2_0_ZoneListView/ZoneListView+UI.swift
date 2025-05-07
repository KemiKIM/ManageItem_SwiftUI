//
//  ZoneListView+UI.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/7/25.
//

import SwiftUI
import SFSafeSymbols

extension ZoneListView {
    
    var zoneList: some View {
        return List {
            
            ForEach(zones, id: \.self) { zone in
                
                Button(action: {
                    print("\(zone) 클릭됨")
                    DispatchQueue.main.async {
                        viewRouter.navigateZone(to: .detail(zone: zone))
                    }
                }) {
                    HStack {
                        Image(systemSymbol: returnIcon(zone: zone))
                            .foregroundColor(Color.primary)
                        Text("\(zone) 구역")
                            .font(.headline)
                            .foregroundColor(Color.primary)
                        
                    }
                }
                
            }
        }
        .listStyle(.insetGrouped)
    }
    
}
