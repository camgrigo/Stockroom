//
//  OrdersView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/17/20.
//

import SwiftUI
import CoreData

struct OrdersView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: LiteratureOrder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureOrder.date, ascending: true)],
        animation: .default
    )
    private var orders: FetchedResults<LiteratureOrder>
    
    private var items: Dictionary<String, [LiteratureOrder]> {
        switch grouping {
        case .requestDate:
            return Dictionary(grouping: orders) {
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                
                return dateFormatter.string(from: $0.date!)
            }
        case .recipient:
            return Dictionary(grouping: orders) { $0.recipient! }
        case .item:
            return Dictionary(grouping: orders) { $0.item!.title! }
        }
    }
    
    
    let navigationTitle = "Orders"
    
    @State private var isShowingItemsSheet = false
    
    @State private var isShowingNewOrderSheet = false
    
    
    enum Grouping: CaseIterable {
        case requestDate, recipient, item
        
        var title: String {
            switch self {
            case .requestDate:
                return "Most to Least Recent"
            case .recipient:
                return "Recipients"
            case .item:
                return "Items"
            }
        }
    }
    
    @State private var grouping = Grouping.requestDate
    
    
    var body: some View {
        Group {
            if items.count > 0 {
                ScrollView {
                    LazyVStack {
                        switch grouping {
                        case .requestDate:
                            AnyView(OrdersListRequestDateView(items: items))
                            
                        case .recipient:
                            AnyView(OrdersListRecipientView(items: items))
                            
                        case .item:
                            AnyView(OrdersListItemView(items: items))
                        }
                    }
                }
                
            } else {
                ListDefaultView(text: "Record orders as you place them.", action: addItem) {
                    Image(systemName: "paperplane")
                }
                .foregroundColor(.secondary)
            }
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddButton(action: addItem)
                    .sheet(isPresented: $isShowingNewOrderSheet) {
                        NewOrderView(isShowing: $isShowingNewOrderSheet)
                    }
            }
            ToolbarItem(placement: ToolbarItemPlacement.navigation) {
                Menu {
                    Picker(selection: $grouping, label: Text("View")) {
                        ForEach(Grouping.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                }
                label: {
                    Label("View", systemImage: "rectangle.grid.1x2")
                }
            }
        }
    }
    
    
    private func addItem() {
        isShowingNewOrderSheet = true
    }
    
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets
    //                .map { items[$0] }
    //                .forEach(viewContext.delete)
    //
    //            PersistenceController.save(viewContext)
    //        }
    //    }
    
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
