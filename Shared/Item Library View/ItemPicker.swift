//
//  ItemPicker.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/22/20.
//

import SwiftUI

struct ItemPicker: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureItem.title, ascending: true)], animation: .default)
    private var literatureItems: FetchedResults<LiteratureItem>
    
    
    @ObservedObject var itemDraft: RequestItemDraft
    
    
    @State private var isShowingNewItemSheet = false
    
    @State private var isShowingDetail = true
    
    
    var body: some View {
        if literatureItems.isEmpty {
            NewItemButton(isShowingNewItemSheet: $isShowingNewItemSheet)
            
        } else {
            NavigationLink(
                destination: Detail(isShowing: $isShowingDetail, itemDraft: itemDraft)
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext),
                isActive: $isShowingDetail
            ) {
                if let title = itemDraft.literatureItem?.title,
                   let icon = itemDraft.literatureItem?.icon {
                    Label(title, systemImage: icon)
                } else {
                    Text("Select Item")
                }
            }
            .isDetailLink(false)
        }
    }
    
}

extension ItemPicker {
    
    struct NewItemButton: View {
        
        @Binding var isShowingNewItemSheet: Bool
        
        var body: some View {
            Button {
                isShowingNewItemSheet = true
            } label: {
                Label("NEW_LITERATURE_ITEM_FORM_TITLE", systemImage: "plus")
            }
            .sheet(isPresented: $isShowingNewItemSheet) {
                NewLiteratureItemSheet(isShowing: $isShowingNewItemSheet)
            }
        }
        
    }
    
}

extension ItemPicker {
    
    struct Detail: View {
        
        @Environment(\.managedObjectContext) var viewContext
        
        @Binding var isShowing: Bool
        
        @State private var isShowingNewItemSheet = false
        
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureItem.title, ascending: true)], animation: .default)
        private var literatureItems: FetchedResults<LiteratureItem>
        
        @ObservedObject var itemDraft: RequestItemDraft
        
        
        var body: some View {
            List {
                ForEach(literatureItems) { item in
                    Button {
                        itemDraft.literatureItem = item
                        isShowing = false
                    } label: {
                        row(item: item)
                    }
                }
                NewItemButton(isShowingNewItemSheet: $isShowingNewItemSheet)
            }
            .navigationTitle("Select Item")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { isShowing = true }
        }
        
        private func row(item: LiteratureItem) -> some View {
            HStack {
                Label(item.title!, systemImage: item.icon!)
                Spacer()
                if item == itemDraft.literatureItem {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
        
    }
    
}

