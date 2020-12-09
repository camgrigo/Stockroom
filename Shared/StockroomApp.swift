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
    
    @State private var selectedTab = Tab.orders
    
    @ObservedObject var modalManager = ModalManager()
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
//                .accentColor(accentColor)
                .environmentObject(modalManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}

//extension StockroomApp {
//
//    private var accentColor: Color {
//        switch colorScheme {
//        case .dark:
//            return Color(#colorLiteral(red: 0, green: 1, blue: 0.870255982, alpha: 1))
//
//        default:
//            return Color(#colorLiteral(red: 0, green: 0.6012692752, blue: 0.5962586979, alpha: 1))
//        }
//    }
//
//}
