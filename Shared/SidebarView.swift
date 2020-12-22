//
//  SidebarView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/12/20.
//

import SwiftUI
import CoreData

struct SidebarView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureRequest.date, ascending: true)], animation: .default)
    private var literatureRequests: FetchedResults<LiteratureRequest>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureItem.title, ascending: true)], animation: .default)
    private var literatureItems: FetchedResults<LiteratureItem>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Shipment.trackingNumber, ascending: true)], animation: .default)
    private var shipments: FetchedResults<Shipment>
    
    
    @Binding var selectedTab: StockroomApp.Tab
    
    
    private func detail(tab: StockroomApp.Tab) -> String {
        switch tab {
        case .requests:
            return "\(literatureRequests.count)"
        
        case .itemLibrary:
            return "\(literatureItems.count)"
            
        case .shipments:
            return "\(shipments.count)"
            
        case .settings:
            return ""
        }
    }
    
    private func row(tab: StockroomApp.Tab, detailColor: Color) -> some View {
        HStack {
            Label(tab.title, systemImage: tab.systemImage)
            Spacer()
            Text(detail(tab: tab)).foregroundColor(detailColor)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
    }
    
    var body: some View {
        List(StockroomApp.Tab.allCases, id: \.self) { tab in
            Button {
                selectedTab = tab
            } label: {
                if tab == selectedTab {
                    row(tab: tab, detailColor: .white)
                        .foregroundColor(.white)
                        .background(Color.blue.cornerRadius())
                    
                } else {
                    row(tab: tab, detailColor: .secondary)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle(Text(LocalizedStringKey("Sidebar_Navigation_Title")))
    }
}
