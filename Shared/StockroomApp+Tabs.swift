//
//  StockroomApp+Tabs.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/6/20.
//

import SwiftUI

struct CustomTabView: View {
    
    typealias Tab = StockroomApp.Tab // TODO: Remove hardcoded typealias
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var selectedTab = Tab.orders
    
    
    private var tabView: some View {
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
    }
    
    private var sidebarView: some View {
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
    }
    
    var body: some View {
        #if os(iOS)
        switch horizontalSizeClass {
        case .compact:
            tabView
        default:
            sidebarView
        }
        #else
        sidebarView
        #endif
    }
    
}

extension StockroomApp {
    
    enum Tab: CaseIterable {
        
        case orders, itemLibrary, shipments, settings
        
        
        var systemImage: String {
            switch self {
            case .orders:
                return "paperplane.fill"
            case .shipments:
                return "shippingbox.fill"
            case .itemLibrary:
                return "books.vertical.fill"
            case .settings:
                return "gearshape.fill"
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
            case .settings:
                return "Settings"
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
            
            case .settings:
                return AnyView(
                    Text("Settings")
                )
            }
        }
        
    }
    
}
