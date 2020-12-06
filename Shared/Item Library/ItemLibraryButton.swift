////
////  ItemLibraryButton.swift
////  Stockroom
////
////  Created by Cameron Grigoriadis on 11/24/20.
////
//
//import SwiftUI
//
//struct ItemLibraryButton: View {
//    
//    @Binding var isShowingItemLibrary: Bool
//    
//    
//    var body: some View {
//        Button {
//            isShowingItemLibrary = true
//        } label: {
//            HStack {
//                Image(systemName: "books.vertical.fill")
//                Text("Item Library").bold()
//            }
//        }
//        .sheet(isPresented: $isShowingItemLibrary) {
//            ItemLibraryView(isShowing: $isShowingItemLibrary) { item in
//                NavigationLink(destination: Text("Destination")) {
//                    LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
//                }
//            }
//        }
//    }
//    
//}
//
//struct ItemsButton_Previews: PreviewProvider {
//    @State private static var isShowingItemsSheet = false
//    
//    static var previews: some View {
//        ItemLibraryButton(isShowingItemLibrary: $isShowingItemsSheet)
//    }
//}
