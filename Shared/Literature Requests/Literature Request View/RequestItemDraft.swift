//
//  NewOrder.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/26/20.
//

import SwiftUI
import CoreData

final class LiteratureRequestDraft: ObservableObject, Identifiable {
    
    @Published var date = Date()
    
    @Published var isRecurring = false
    
    @Published var recipient = String()
    
    @Published var items = [RequestItemDraft]()
    
    
    var isValid: Bool {
        !items.isEmpty && items.allSatisfy { $0.literatureItem != nil }
    }
    
    
    func commit() {
        let context = PersistenceController.shared.container.viewContext

        let request = LiteratureRequest(context: context)
        
        request.date = date
        request.recipient = recipient
        request.isRecurring = isRecurring
        
        items.forEach { item in
            let requestItem = LiteratureRequestItem(context: context)

            requestItem.quantity = Int32(item.quantity)
            requestItem.item = context.object(with: item.literatureItem!.objectID) as? LiteratureItem
            requestItem.request = request
        }
        
        PersistenceController.save(context)
    }
    
}

final class RequestItemDraft: ObservableObject, Identifiable {

    @Published var quantity = 1

    @Published var literatureItem: LiteratureItem?
    
}
