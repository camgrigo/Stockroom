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
        Dictionary(grouping: orders) { order in
            switch grouping {
            case .requestDate:
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                
                return dateFormatter.string(from: order.date!)
                
            case .recipient:
                return order.recipient!
                
            case .item:
                return order.item!.title!
            }
        }
    }
    
    
    let navigationTitle = "Orders"
    
    @State private var isShowingItemsSheet = false
    
    @State private var isShowingNewOrderSheet = false
    
    @State private var grouping = Grouping.requestDate
    
    
    var body: some View {
        Group {
            if items.count > 0 {
                ScrollView {
                    LazyVStack {
                        ViewMenu(grouping: $grouping)
                        
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
            AddButton(action: addItem)
                .sheet(isPresented: $isShowingNewOrderSheet) {
                    NewOrderView(isShowing: $isShowingNewOrderSheet)
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

extension OrdersView {
    
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
    
}

extension OrdersView {
    
    struct ViewMenu: View {
        
        @Binding var grouping: OrdersView.Grouping
        
        var body: some View {
            Menu {
                Picker(selection: $grouping, label: Text("View")) {
                    ForEach(Grouping.allCases, id: \.self) {
                        Text($0.title)
                    }
                }
            }
            label: {
                HStack {
                    Label("View", systemImage: "rectangle.grid.2x2")
                    Spacer()
                    Text(grouping.title).animation(nil)
                }
                    .padding()
                    .background(Color.blue.opacity(0.15).cornerRadius(15))
                    .padding()
            }
        }
        
    }
    
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
