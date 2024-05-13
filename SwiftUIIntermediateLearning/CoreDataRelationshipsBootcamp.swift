//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 12/05/2024.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context : NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded Core Data.")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("ERROR saving. \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @State var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}
