//
//  NewRequestItemView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/12/20.
//

import SwiftUI

struct NewRequestItemView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureItem.title, ascending: true)], animation: .default)
    private var literatureItems: FetchedResults<LiteratureItem>
    
    @State private var isShowingNewItemSheet = false
    
    private var interval: Int {
        Int(itemDraft.literatureItem?.category?.quantityPerGrouping ?? 1) // TODO: Force unwrap once category work is finished
    }
    
    
    @ObservedObject var requestDraft: LiteratureRequestDraft
    
    @ObservedObject var itemDraft: RequestItemDraft
    
    private var draftIndex: Int {
        requestDraft.items
            .firstIndex { $0.literatureItem == itemDraft.literatureItem }!
    }
    
    
    var body: some View {
        if literatureItems.isEmpty {
            newItemButton
        } else {
            Picker(itemDraft.literatureItem?.title ?? "Item", selection: $itemDraft.literatureItem) {
                ForEach(literatureItems, content: pickerItemRow)
            }
        }
        
        QuantityStepper(value: $requestDraft.items[draftIndex].quantity, step: interval)
    }
    
    private var newItemButton: some View {
        Button {
            isShowingNewItemSheet = true
        } label: {
            Label("NEW_LITERATURE_ITEM_FORM_TITLE", systemImage: "plus")
        }
        .sheet(isPresented: $isShowingNewItemSheet) {
            NewLiteratureItemSheet(isShowing: $isShowingNewItemSheet)
        }
    }
    
    private func pickerItemRow(item: LiteratureItem) -> some View {
        Text(item.title!)
    }
    
}
