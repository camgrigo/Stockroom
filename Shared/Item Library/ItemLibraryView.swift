//
//  ItemLibraryView.swift
//  Shared
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import SwiftUI
import CoreData

struct ItemLibraryView<Cell: View>: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: LiteratureItem.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var items: FetchedResults<LiteratureItem>
    
    
    private let navigationTitle = "Item Library"
    
    @State private var isShowingNewItemSheet = false
    
    let cellProvider: (LiteratureItem) -> Cell
    
    
    var body: some View {
        Group {
            if items.count > 0 {
                list
                
            } else {
                ListDefaultView(text: "Add a book, magazine,\nor other publication", action: addItem) {
                    Image(systemName: "books.vertical")
                }
                .foregroundColor(.secondary)
            }
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddButton(action: addItem)
            }
        }
        .sheet(isPresented: $isShowingNewItemSheet) {
            NewLiteratureItemView(isShowing: $isShowingNewItemSheet)
        }
    }
    
    private var list: some View {
        List {
            ForEach(items) {
                cellProvider($0)
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    
    private func addItem() {
        isShowingNewItemSheet = true
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets
                .map { items[$0] }
                .forEach(viewContext.delete)
            
            PersistenceController.save(viewContext)
        }
    }
    
}

struct LiteratureItemsListView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemLibraryView { item in
            LiteratureItemCell(model: LiteratureItemCellViewModel(icon: item.icon ?? String(), title: item.title ?? String()))
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
