//
//  OrdersView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/17/20.
//

import SwiftUI
import CoreData

struct OrdersViewGroupingKey: EnvironmentKey {
    static var defaultValue: OrdersView.Grouping = .requestDate
}

extension EnvironmentValues {
    var grouping: OrdersView.Grouping {
        get { self[OrdersViewGroupingKey.self] }
        set { self[OrdersViewGroupingKey.self] = newValue }
    }
}

struct OrdersView: View {
    
    @EnvironmentObject private var modalManager: ModalManager
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: LiteratureOrder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureOrder.date, ascending: true)],
        animation: .default
    )
    private var orders: FetchedResults<LiteratureOrder>
    
    
    let navigationTitle = "Orders"
    
    @State private var grouping = OrdersView.Grouping.requestDate
    
    
    @State private var searchText = String()
    
    var sections: [(title: String, items: [LiteratureOrder])] {
        switch grouping {
        case .requestDate:
            return Dictionary(grouping: orders) { $0.date! }
            .sorted { $0.0 > $1.0 }
                .map { pair in (title: {
                        let dateFormatter = DateFormatter()
                        
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .none
                        
                    return dateFormatter.string(from: pair.0)
                }(), items: pair.1) }
            
        default:
            return Dictionary(grouping: orders) { order in
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
            .sorted { $0.0 < $1.0 }
            .map { (title: $0.0, items: $0.1) }
        }
    }
    
    
    var body: some View {
        Group {
            if !sections.isEmpty {
                List {
                    SearchBar(text: $searchText)
                    
                    ForEach(sections, id: \.title) { section in
                        OrdersListSection(section: section) {
                            ForEach(section.items) {
                                OrderRow(order: $0)
                            }
                        }
                        .environment(\.grouping, grouping)
                    }
                    
                    OverscrollSpacer()
                }
                
            } else {
                ListDefaultView(text: "Record orders as you place them.", action: { modalManager.isShowingNewOrderSheet = true }) {
                    Image(systemName: "paperplane")
                }
                .foregroundColor(.secondary)
            }
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ViewMenu(grouping: $grouping)
        }
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
                return "Recently Added"
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
        
        @EnvironmentObject var modalManager: ModalManager
        
        @Binding var grouping: OrdersView.Grouping
        
        var body: some View {
            Menu {
                Section {
                    Button {
                        modalManager.isShowingNewOrderSheet = true
                    } label: {
                        Label("New Order", systemImage: "square.and.pencil")
                    }
                }
                
                Section {
                    Picker(selection: $grouping, label: Text("View")) {
                        ForEach(Grouping.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                }
            }
            label: {
                Label("Menu", systemImage: "ellipsis.circle")
                    .imageScale(.large)
            }
        }
        
    }
    
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
