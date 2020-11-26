//
//  ContentView.swift
//  Shared
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import SwiftUI
import CoreData

struct LiteratureItemsListView<Cell: View>: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: LiteratureItem.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var items: FetchedResults<LiteratureItem>
    
    
    @Binding var isShowing: Bool
    
    private let navigationTitle = "Items"
    
    @State private var isShowingNewItemSheet = false
    
    let cellProvider: (LiteratureItem) -> Cell
    
    var body: some View {
        NavigationView {
            Group {
                if items.count > 0 {
                    List {
                        ForEach(items) {
                            cellProvider($0)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                } else {
                    ListDefaultView(text: "Add a book, magazine,\nor other publication", action: addItem) {
                        Image(systemName: "books.vertical")
                    }
                    .foregroundColor(.secondary)
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isShowing = false }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addItem) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingNewItemSheet) {
                NewLiteratureItemView(isShowing: $isShowingNewItemSheet)
            }
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
    
    @State private static var isShowing = true
    
    static var previews: some View {
        LiteratureItemsListView(isShowing: $isShowing) {
            LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: $0))
        }
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
