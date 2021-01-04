//
//  NewLiteratureItemForm.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/21/20.
//

import SwiftUI

struct NewLiteratureItemForm: View {
    
    @Binding var title: String
    
    @Binding var icon: LiteratureItem.Icon
    
    
    private struct Font {
        static let itemTitle = SwiftUI.Font.title3
    }
    
    
    var body: some View {
        List {
            HStack {
                if !title.isEmpty {
                    Text(LocalizedStringKey("NEW_LITERATURE_ITEM_FORM_TITLE_FIELD_TITLE"))
                        .font(Font.itemTitle.bold())
                }
                TextField(LocalizedStringKey("NEW_LITERATURE_ITEM_FORM_TITLE_FIELD_TITLE"), text: $title)
                    .font(Font.itemTitle.italic())
                    .iOS { $0.autocapitalization(.words) }
            }
            .padding(.vertical)
            
            IconPicker(icons: LiteratureItem.Icon.allCases, selection: $icon)
        }
    }
    
}

//
//struct NewLiteratureItemForm: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @Binding var isShowing: Bool
//    
//    
//    @State private var title = String()
//    
//    @State private var icon = LiteratureItem.Icon.default
//    
//    var isValid: Bool {
//        !title.isEmpty
//    }
//    
//    
//    var body: some View {
//        VStack {
//            Text("New Item").font(.title)
//            LiteratureItemForm(title: $title, icon: $icon)
//                .padding(.top)
//        }
//        .toolbar {
//            Button(action: done) {
//                Text("Done").bold()
//            }
//            .disabled(!isValid)
//        }
//    }
//    
//    private func done() {
//        isShowing = false
//        
////        withAnimation {
////            let literatureItem = LiteratureItem(context: viewContext)
////
////            literatureItem.id = UUID()
////            literatureItem.title = title
////            literatureItem.icon = icon.rawValue
////            literatureItem.color = LiteratureItem.defaultColor
////            literatureItem.symbol = nil
////
////            let category = LiteratureItemCategory(context: viewContext)
////
////            category.name = "Publication"
////
////            literatureItem.category = category
////
////            PersistenceController.save(viewContext)
////        }
//    }
//    
//}
