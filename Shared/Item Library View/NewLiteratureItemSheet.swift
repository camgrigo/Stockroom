//
//  NewLiteratureItemSheet.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/21/20.
//

import SwiftUI
import CoreData

struct NewLiteratureItemSheet: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @Binding var isShowing: Bool
    
    private let navigationTitle: LocalizedStringKey = "NEW_LITERATURE_ITEM_FORM_TITLE"
    
    @ObservedObject private var model = NewLiteratureItemSheetModel()
    
    
    var body: some View {
        NavigationView {
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
    
}
