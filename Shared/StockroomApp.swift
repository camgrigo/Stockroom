//
//  StockroomApp.swift
//  Shared
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import SwiftUI

@main
struct StockroomApp: App {
    
    enum Tab: CaseIterable {
        
        case orders, itemLibrary, shipments
        
        
        var systemImage: String {
            switch self {
            case .orders:
                return "paperplane.fill"
            case .shipments:
                return "shippingbox.fill"
            case .itemLibrary:
                return "books.vertical.fill"
            }
        }
        
        var title: String {
            switch self {
            case .orders:
                return "Orders"
            case .shipments:
                return "Shipments"
            case .itemLibrary:
                return "Library"
            }
        }
        
        var view: AnyView {
            switch self {
            case .orders:
                return AnyView(OrdersView())
            case .shipments:
                return AnyView(ShipmentsView())
                
            case .itemLibrary:
                return AnyView(
                    ItemLibraryView { item in
                        NavigationLink(destination: LiteratureItemDetail(item: item)) {
                            LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
                        }
                    }
                )
            }
        }
        
    }
    
    let persistenceController = PersistenceController.shared
    
    @State private var selectedTab = Tab.orders
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            TabView {
                ForEach(Tab.allCases, id: \.self) { tab in
                    NavigationView {
                        tab.view
                    }
                    .tabItem {
                        Group {
                            Image(systemName: tab.systemImage)
                            Text(tab.title)
                        }
                    }
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #else
            NavigationView {
                List(Tab.allCases, id: \.self) { tab in
                    Label(tab.title, systemImage: tab.systemImage)
                        .onTapGesture { selectedTab = tab }
                }
                .listStyle(SidebarListStyle())
                .navigationTitle("Stockroom")
                
                selectedTab.view
                
                Text("Content")
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            #endif
        }
    }
    
}
