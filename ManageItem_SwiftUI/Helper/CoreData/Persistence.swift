//
//  Persistence.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/16/25.
//

import SwiftUI
import CoreData


struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NoAuthModel") // 모델 파일 이름
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
