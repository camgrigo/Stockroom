//
//  CustomTabView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/12/20.
//

import SwiftUI

struct CustomTabView: View {
    
    typealias Tab = StockroomApp.Tab // TODO: Remove hardcoded typealias
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    @State private var selectedTab = Tab.requests
    
    
    var body: some View {
        #if os(iOS)
        switch horizontalSizeClass {
        case .compact:
            StockroomTabView()
        default:
            NavigationView {
                SidebarView(selectedTab: $selectedTab)
                
                selectedTab.view
                
                Text("Content")
            }
        }
        #else
            NavigationView {
                SidebarView(selectedTab: $selectedTab)
                
                selectedTab.view
                
                Text("Content")
            }
        #endif
    }
    
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
