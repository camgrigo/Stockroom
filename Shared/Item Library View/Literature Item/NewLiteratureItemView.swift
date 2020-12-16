//
//  NewLiteratureItemView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

struct NewLiteratureItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isShowing: Bool
    
    private let navigationTitle: LocalizedStringKey = "NEW_LITERATURE_ITEM_FORM_TITLE"
    
    
    @State private var title = String()
    
    @State private var icon = LiteratureItem.Icon.default
    
    
    var body: some View {
        NavigationView {
            LiteratureItemForm(title: $title, icon: $icon)
                .navigationTitle(navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            isShowing = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: done) {
                            Text("Done")
                        }
                    }
                }
        }
    }
    
    private func done() {
        isShowing = false
        
        withAnimation {
            let literatureItem = LiteratureItem(context: viewContext)
            
            literatureItem.id = UUID()
            literatureItem.title = title
            literatureItem.icon = icon.rawValue
            literatureItem.color = LiteratureItem.defaultColor
            literatureItem.symbol = nil
            
            let category = LiteratureItemCategory(context: viewContext)
            
            category.name = "Publication"
            
            literatureItem.category = category
            
            PersistenceController.save(viewContext)
        }
    }
    
}

struct NewLiteratureItemForm: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isShowing: Bool
    
    
    @State private var title = String()
    
    @State private var icon = LiteratureItem.Icon.default
    
    
    var body: some View {
        VStack {
            LiteratureItemForm(title: $title, icon: $icon)
                .padding(.top)
            
            Button(action: done) {
                Text("Done").bold()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue.cornerRadius(12))
            .padding(.vertical, 20)
            .disabled(title.isEmpty)
        }
    }
    
    private func done() {
        isShowing = false
        
        withAnimation {
            let literatureItem = LiteratureItem(context: viewContext)
            
            literatureItem.id = UUID()
            literatureItem.title = title
            literatureItem.icon = icon.rawValue
            literatureItem.color = LiteratureItem.defaultColor
            literatureItem.symbol = nil
            
            let category = LiteratureItemCategory(context: viewContext)
            
            category.name = "Publication"
            
            literatureItem.category = category
            
            PersistenceController.save(viewContext)
        }
    }
    
}

struct NewLiteratureItemView_Previews: PreviewProvider {
    @State static private var isShowing = true
    
    static var previews: some View {
        NewLiteratureItemView(isShowing: $isShowing)
    }
}
