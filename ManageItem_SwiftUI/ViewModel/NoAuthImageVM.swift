//
//  NoAuthImageVM.swift
//  ManageItem_SwiftUI
//
//  Created by 김성호 on 5/16/25.
//

import Foundation
import CoreData
import Combine

class NoAuthImageVM: ObservableObject {
    private let context: NSManagedObjectContext
    
    // Image
    @Published var models: [NoAuthImage] = []
    
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchModels()
       
    }
    
    // fetch
    func fetchModels() {
        let request: NSFetchRequest<NoAuthImage> = NoAuthImage.fetchRequest()

        do {
            models = try context.fetch(request)
        } catch {
            print("Fetch 실패: \(error)")
        }
    }
    
    // Add
    func add(path: String) {
        let model = NoAuthImage(context: context)
        model.noAuthImage = path

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
