//
//  ItemOptionsSection.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/28/20.
//

import SwiftUI

//struct LiteratureItemPicker: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @Binding var isShowingItemPicker: Bool
//    
//    @ObservedObject var draft: RequestItemDraft
//    
//    
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureItem.title, ascending: true)], animation: .default)
//    private var literatureItems: FetchedResults<LiteratureItem>
//    
//    @State private var title = String()
//    
//    @State private var icon = LiteratureItem.Icon.default
//    
//    
//    private var checkmark: some View {
//        Image(systemName: "checkmark").foregroundColor(.blue)
//    }
//    
//    private func row(item: LiteratureItem) -> some View {
//        Button {
//            withAnimation {
//                draft.literatureItem = item
//                isShowingItemPicker = false
//            }
//        } label: {
//            HStack {
//                LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
//                    .foregroundColor(.primary)
//                Spacer()
//                if item == draft.literatureItem {
//                    checkmark
//                }
//            }
//        }
//    }
//    
//    var body: some View {
//        Group {
//            if literatureItems.isEmpty {
//                ScrollView {
//                    LazyVStack {
//                        LiteratureItemForm(title: $title, icon: $icon)
//                            .padding()
//
////                        Button(action: done) {
////                            Text("Done").bold()
////                        }
////                        .foregroundColor(.white)
////                        .padding()
////                        .background(Color.blue.cornerRadius(12))
////                        .padding(.vertical, 20)
////                        .disabled(title.isEmpty)
//                    }
//                }
//            } else {
//                List {
//                    ForEach(literatureItems) { row(item: $0) }
//                }
//            }
//        }
//        .navigationTitle("Select Item")
//    }
//    
//    private func done() {
//        withAnimation {
//            let literatureItem = LiteratureItem(context: viewContext)
//            
//            literatureItem.id = UUID()
//            literatureItem.title = title
//            literatureItem.icon = icon.rawValue
//            literatureItem.color = LiteratureItem.defaultColor
//            literatureItem.symbol = nil
//            
//            let category = LiteratureItemCategory(context: viewContext)
//            
//            category.name = "Publication"
//            
//            literatureItem.category = category
//            
//            PersistenceController.save(viewContext)
//        }
//    }
//    
//}
