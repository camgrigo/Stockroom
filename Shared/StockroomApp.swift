//
//  StockroomApp.swift
//  Shared
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import SwiftUI

@main
struct StockroomApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                        OrdersView()
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
                .tabItem {
                    Image(systemName: "paperplane.fill")
                    Text("Orders")
                }
                
                NavigationView {
                    ListDefaultView(text: "No shipments yet.", action: {}) {
                        Image(systemName: "shippingbox")
                    }
                        .navigationTitle("Shipments")
                }
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Shipments")
                }
            }
        }
    }
}
