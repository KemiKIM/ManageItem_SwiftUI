//
//  TestView.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/15/25.
//

import SwiftUI
import CoreData

struct CoreDataTestView: View {
    @StateObject private var noAuthModel = NoAuthModelViewModel()

    var body: some View {
        List {
            ForEach(noAuthModel.models, id: \.objectID) { model in
                Text(model.name ?? "No Content")
                Text(model.partName ?? "No Content")
                Text(model.location ?? "No Content")
                Text(model.serialNumber ?? "No Content")
            }
            .onDelete(perform: noAuthModel.delete(at:))
        }
        
        Button("Add") {
            
            if noAuthModel.totalCount > 4 {
                let _ = print("5개 이상됨.")
            } else {
                noAuthModel.add(
                    name: "새 항목",
                    location: "서울",
                    partName: "센서",
                    serialNumber: UUID().uuidString
                )
            }
           
        }
        
    }

}



