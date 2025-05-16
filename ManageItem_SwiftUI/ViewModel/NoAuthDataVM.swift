//
//  NoAuthDataVM.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/16/25.
//

import Foundation
import CoreData
import Combine

class NoAuthDataVM: ObservableObject {
    private let context: NSManagedObjectContext

    // Data
    @Published var models: [NoAuthData] = []

   
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchModels()
    }

    
    
    // fetch
    func fetchModels() {
        let request: NSFetchRequest<NoAuthData> = NoAuthData.fetchRequest()

        do {
            models = try context.fetch(request)
        } catch {
            print("Fetch 실패: \(error)")
        }
    }

    // Add
    func add(name: String, location: String?, partName: String?, serialNumber: String?) {
        let model = NoAuthData(context: context)
        model.name = name
        model.location = location
        model.partName = partName
        model.serialNumber = serialNumber

        saveContext()
        fetchModels()
    }
    
    // Update
    func update(model: NoAuthData, newName: String, newLocation: String?, newPartName: String?, newSerialNumber: String?) {
        model.name = newName
        model.location = newLocation
        model.partName = newPartName
        model.serialNumber = newSerialNumber

        saveContext()
        fetchModels()
    }

    // Delete
    func delete(at offsets: IndexSet) {
        offsets.map { models[$0] }.forEach(context.delete)
        saveContext()
        fetchModels()
    }

    // Total Count
    var totalCount: Int {
        models.count
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("저장 실패: \(error)")
            }
        }
    }
}
