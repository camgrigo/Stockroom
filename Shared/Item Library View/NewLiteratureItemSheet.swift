//
//  NewLiteratureItemSheet.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/21/20.
//

import SwiftUI
import CoreData

class NewLiteratureItemSheetModel: ObservableObject {
    
    @Published var title = String()
    
    @Published var icon = LiteratureItem.Icon.default
    
    var isValid: Bool { !title.isEmpty }
    
    
    func commit(context: NSManagedObjectContext) {
        withAnimation {
            let literatureItem = LiteratureItem(context: context)
            
            literatureItem.id = UUID()
            literatureItem.title = title
            literatureItem.icon = icon.rawValue
            literatureItem.color = LiteratureItem.defaultColor
            literatureItem.symbol = nil
            
            let category = LiteratureItemCategory(context: context)
            
            category.name = "Publication"
            
            literatureItem.category = category
            
            PersistenceController.save(context)
        }
    }
    
}

struct NewLiteratureItemSheet: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var isShowing: Bool
    
    private let navigationTitle: LocalizedStringKey = "NEW_LITERATURE_ITEM_FORM_TITLE"
    
    @ObservedObject private var model = NewLiteratureItemSheetModel()
    
    
    var body: some View {
        NewLiteratureItemForm(title: $model.title, icon: $model.icon)
            .navigationTitle(navigationTitle)
            .toolbar {
                FormToolbar(canSubmit: model.isValid) {
                    isShowing = false
                } done: {
                    isShowing = false
                    model.commit(context: viewContext)
                }
            }
    }
    
}
