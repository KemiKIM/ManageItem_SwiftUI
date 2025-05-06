//
//  ConfirmZoneView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 4/27/25.
//

import SwiftUI
import SFSafeSymbols

struct ConfirmZoneView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    let zones = ["A", "B", "C", "D", "E"]
    
    var body: some View {
        
        
        ZStack {
            Color(Color.customColor) // systemBackground는 다크 모드에서 진한 검정
                 .ignoresSafeArea()
            
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 60)
            
            Text("배치도")
                .padding(.leading, 30)
                .font(.title)
                .fontWeight(.bold)
            
            
            List {
                
                ForEach(zones, id: \.self) { zone in
                    
                    
                    Button(action: {
                        print("\(zone) 클릭됨")
                        DispatchQueue.main.async {
                            viewRouter.navigateZone(to: .imagezone(zone: zone))
                        }
                    }) {
                        HStack {
                            Image(systemSymbol: imageName(for: zone))
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
    }
    
    
    
    func imageName(for zone: String) -> SFSymbol {
          switch zone {
          case "A": return .aSquare
          case "B": return .bSquare
          case "C": return .cSquare
          case "D": return .dSquare
          case "E": return .eSquare
          default: return .aSquare
          }
      }
    
}
