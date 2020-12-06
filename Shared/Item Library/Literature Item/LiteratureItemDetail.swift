//
//  LiteratureItemDetail.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/3/20.
//

import SwiftUI

struct LiteratureItemDetail: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let item: LiteratureItem
    
    
    init(item: LiteratureItem) {
        self.item = item
        _title = State(initialValue: item.title!)
        _icon = State(initialValue: LiteratureItem.Icon(rawValue: item.icon!)!)
    }
    
    @State private var title = String()
    
    @State private var icon = LiteratureItem.Icon.default
    
    
    @State private var isShowingConfirmDelete = false
    
    
    private var content: some View {
        ScrollView {
            LazyVStack {
                LiteratureItemForm(title: $title, icon: $icon)
                    .onDisappear {
                        withAnimation {
                            item.title = title
                            item.icon = icon.rawValue
                            
                            PersistenceController.save(viewContext)
                        }
                    }
                Button (action: confirmDelete) {
                    HStack {
                        Label("Delete", systemImage: "trash.fill")
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
                .padding()
                .background(Color.secondary.opacity(0.2).cornerRadius(10))
            }
        }
    }
    
    var body: some View {
        #if os(iOS)
        content
            .actionSheet(isPresented: $isShowingConfirmDelete) {
                ActionSheet(title: Text("Delete \(title)"), buttons: [
                    Alert.Button.destructive(Text("Delete"), action: delete),
                    Alert.Button.cancel { isShowingConfirmDelete = false }
                ])
            }
        #else
        content
            .alert(isPresented: $isShowingConfirmDelete) {
                Alert(
                    title: Text("Delete \(title)"),
                    message: Text("Are you sure you want to delete this literature item?"),
                    primaryButton: Alert.Button.destructive(Text("Delete"), action: delete),
                    secondaryButton: Alert.Button.cancel { isShowingConfirmDelete = false }
                )
            }
        #endif
    }
    
    
    private func confirmDelete() {
        isShowingConfirmDelete = true
    }
    
    private func delete() {
        withAnimation {
            viewContext.delete(item)
            
            PersistenceController.save(viewContext)
        }
    }
    
}

//struct LiteratureItemDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        LiteratureItemDetail()
//    }
//}
