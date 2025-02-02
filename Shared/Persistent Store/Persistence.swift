//
//  Persistence.swift
//  Shared
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
//        for i in 0..<10 {
//            let newItem = LiteratureItem(context: viewContext)
//            newItem.id = UUID()
//            newItem.title = "New Item \(i)"
//            newItem.icon = "book.fill"
//        }
//        
//        let request = LiteratureRequest(context: viewContext)
//        
//        let item = LiteratureItem(context: viewContext)
//        
//        item.title = "Suffering Tracts"
//        item.icon = LiteratureItem.Icon.book.rawValue
//        
//        request.date = Date()
//        request.recipient = "Steve Jones"
//        request.isRecurring = false
        
//        let order = LiteratureOrder(context: viewContext)
//
//        order.item = item
//        order.quantity = 256
//
//        request.items.append(order)
        
        save(viewContext)
        
        return result
    }()
    
    static func save(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Stockroom")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
