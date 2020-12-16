//
//  StockroomApp.swift
//  Shared
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import SwiftUI

class ModalManager: NSObject, ObservableObject {
    
    @Published var isShowingItemsSheet = false
    
    @Published var isShowingNewOrderSheet = false
    
}

@main
struct StockroomApp: App {
    
    @Environment(\.colorScheme) var colorScheme
    
    let persistenceController = PersistenceController.shared
    
    @State private var selectedTab = Tab.requests
    
    @ObservedObject var modalManager = ModalManager()
    
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
                .environmentObject(modalManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .sheet(isPresented: $modalManager.isShowingNewOrderSheet) {
                    NewRequestView(isShowing: $modalManager.isShowingNewOrderSheet)
                }
        }
    }
    
}
