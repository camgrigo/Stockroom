//
//  NewRequestItemView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/12/20.
//

import SwiftUI

struct NewRequestItemView: View {
    
    private var interval: Int {
        Int(itemDraft.literatureItem?.category?.quantityPerGrouping ?? 1) // TODO: Force unwrap once category work is finished
    }
    
    @ObservedObject var requestDraft: LiteratureRequestDraft
    
    @ObservedObject var itemDraft: RequestItemDraft
    
    
    let delete: () -> Void
    
    
    private var draftIndex: Int? {
        requestDraft.items
            .firstIndex { $0.literatureItem == itemDraft.literatureItem }
    }
    
    
    var body: some View {
        ItemPicker(itemDraft: itemDraft)
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        if let index = draftIndex {
            QuantityStepper(value: $requestDraft.items[index].quantity, step: interval)
        }
        Button(action: delete) {
            Label("Delete", systemImage: "trash")
        }

    }
    
}
