//
//  StockroomTabView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/12/20.
//

import SwiftUI

struct StockroomTabView: View {
    
    var body: some View {
        TabView {
            ForEach(StockroomApp.Tab.allCases, id: \.self) { tab in
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
    
}

struct StockroomTabView_Previews: PreviewProvider {
    static var previews: some View {
        StockroomTabView()
    }
}
