//
//  ShipmentsView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/29/20.
//

import SwiftUI

struct ShipmentsView: View {
    
    private let navigationTitle: LocalizedStringKey = "Shipments_View_Navigation_Title"
    
    @State private var isShowingNewItemSheet = false
    
    
    var body: some View {
        ListDefaultView(descriptionKey: "Shipments_View_Default_Description", action: { isShowingNewItemSheet = true }) {
            Image(systemName: "shippingbox.fill")
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddButton(action: addItem)
                .sheet(isPresented: $isShowingNewItemSheet) {
                    Text("Not done yet")
                }
            }
        }
    }
    
    
    private func addItem() {
        isShowingNewItemSheet = true
    }
    
}

struct ShipmentsView_Previews: PreviewProvider {
    static var previews: some View {
        ShipmentsView()
    }
}
