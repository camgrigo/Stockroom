//
//  NewLiteratureItemSheetModel.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/22/20.
//

import SwiftUI
import CoreData

class NewLiteratureItemSheetModel: ObservableObject {
    
    @Published var title = String()
    
    @Published var icon = LiteratureItem.Icon.default
    
    var isValid: Bool { !title.isEmpty }
    
    
    func commit(context: NSManagedObjectContext) {
        let context = PersistenceController.shared.container.viewContext
        
        withAnimation {
            let literatureItem = LiteratureItem(context: context)

            literatureItem.id = UUID()
            literatureItem.title = title
            literatureItem.icon = icon.rawValue
            literatureItem.color = LiteratureItem.defaultColor
            literatureItem.symbol = nil
            
            let category = LiteratureItemCategory(context: context)

            category.name = "Publication"

            literatureItem.category = category
            literatureItem.requestItems = nil
            literatureItem.shipmentItems = nil
            
            PersistenceController.save(context)
        }
    }
    
}
