//
//  LiteratureItemsPickerView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/19/20.
//

import SwiftUI

//struct LiteratureItemsPickerView<T: Identifiable>: View {
//    
//    let items: [T]
//    
//    
//    private let navigationTitle = "Select an Item"
//    
//    var body: some View {
//        NavigationView {
//            Group {
//                if items.count > 0 {
//                    List(items) { item in
//                        
//                    }
//                    
//                } else {
//                    ListDefaultView(text: "Add a book, magazine,\nor other publication", action: addItem) {
//                        Image(systemName: "books.vertical")
//                    }
//                    .foregroundColor(.secondary)
//                }
//            }
//                .navigationTitle(navigationTitle)
//        }
//    }
//    
//    
//    private func addItem() {
//        isShowingNewItemSheet = true
//    }
//    
//}
//
//struct LiteratureItemsPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiteratureItemsPickerView()
//    }
//}
