//
//  StockroomApp+Tabs.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/6/20.
//

import SwiftUI

extension StockroomApp {
    
    enum Tab: CaseIterable {
        
        case requests, itemLibrary, shipments, settings
        
        
        var systemImage: String {
            switch self {
            case .requests:
                return "paperplane.fill"
            case .shipments:
                return "shippingbox.fill"
            case .itemLibrary:
                return "books.vertical.fill"
            case .settings:
                return "gearshape.fill"
            }
        }
        
        var title: LocalizedStringKey {
            switch self {
            case .requests:
                return "Requests_View_Navigation_Title"
            case .shipments:
                return "Shipments_View_Navigation_Title"
            case .itemLibrary:
                return "Item_Library_View_Navigation_Title"
            case .settings:
                return "Settings_View_Navigation_Title"
            }
        }
        
        var view: AnyView {
            switch self {
            case .requests:
                return AnyView(LiteratureRequestsView())
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
                return AnyView(SettingsView())
            }
        }
        
    }
    
}
