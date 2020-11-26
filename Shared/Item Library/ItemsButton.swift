//
//  ItemsButton.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/24/20.
//

import SwiftUI

struct ItemsButton: View {
    
    @Binding var isShowingItemsSheet: Bool
    
    
    var body: some View {
        Button {
            isShowingItemsSheet = true
        } label: {
            HStack {
                Image(systemName: "books.vertical")
                Text("Item Library")
            }
        }
        .sheet(isPresented: $isShowingItemsSheet) {
            LiteratureItemsListView(isShowing: $isShowingItemsSheet) { item in
                NavigationLink(destination: Text("Destination")) {
                    LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
                    }
            }
        }
    }
    
}

struct ItemsButton_Previews: PreviewProvider {
    @State private static var isShowingItemsSheet = false
    
    static var previews: some View {
        ItemsButton(isShowingItemsSheet: $isShowingItemsSheet)
    }
}
