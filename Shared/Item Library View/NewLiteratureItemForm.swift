//
//  NewLiteratureItemForm.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/21/20.
//

import SwiftUI

extension View {
    
    func iOS<T: View>(_ modifier: (Self) -> T) -> T {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
}

struct NewLiteratureItemForm: View {
    
    @Binding var title: String
    
    @Binding var icon: LiteratureItem.Icon
    
    
    private let itemTitleFont = Font.title3.italic()
    
    
    var body: some View {
        List {
            TextField("Title", text: $title)
                .font(itemTitleFont)
                .iOS { $0.autocapitalization(.words) }
            
            IconPicker(icons: LiteratureItem.Icon.allCases, selection: $icon)
        }
    }
    
}

//
//struct NewLiteratureItemView: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @Binding var isShowing: Bool
//    
//    private let navigationTitle: LocalizedStringKey = "NEW_LITERATURE_ITEM_FORM_TITLE"
//    
//
//    
//    
//    var body: some View {
//        NavigationView {
//            LiteratureItemForm(title: $title, icon: $icon)
//        }
//    }
//    
//    
//    
//}
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
