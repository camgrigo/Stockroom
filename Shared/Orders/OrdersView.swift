//
//  OrdersView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/17/20.
//

import SwiftUI

struct OrdersView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: LiteratureOrder.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var items: FetchedResults<LiteratureOrder>
    
    
    let navigationTitle = "Orders"
    
    @State private var isShowingItemsSheet = false
    
    @State private var isShowingNewOrderSheet = false
    
    
    var body: some View {
        Group {
            if items.count > 0 {
                List {
                    ForEach(items) { order in
                        OrderRow(model: OrderRowViewModel(order))
                    }
                }
                
            } else {
                ListDefaultView(text: "Record orders as you place them", action: addItem) {
                    Image(systemName: "paperplane")
                }
                .foregroundColor(.secondary)
            }
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                ItemsButton(isShowingItemsSheet: $isShowingItemsSheet)
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button(action: addItem) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isShowingNewOrderSheet) {
                    NewOrderView(isShowing: $isShowingNewOrderSheet)
                }
            }
        }
    }
    
    
    private func addItem() {
        isShowingNewOrderSheet = true
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

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
