//
//  NewRequestView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI
import CoreData

extension LocalizedStringKey {
    
    static let newRequestItemAddButtonLabel: LocalizedStringKey = "ADD_REQUEST_ITEM_BUTTON_LABEL"
    
}

struct NewRequestView: View {
    
    @Binding var isShowing: Bool
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var draft = LiteratureRequestDraft()
    
    private var isValid: Bool {
        !draft.items.isEmpty && draft.items.allSatisfy { $0.literatureItem != nil }
    }
    
    private let navigationTitle: LocalizedStringKey = "New_Request_View_Navigation_Title"
    
    private var itemsSectionHeader: some View {
        Text(LocalizedStringKey("NEW_REQUEST_VIEW_ITEMS_SECTION_TITLE"))
    }
    
    
    var body: some View {
        NavigationView {
            form
                .navigationTitle(navigationTitle)
                .toolbar {
                    FormToolbar(canSubmit: isValid) {
                        isShowing = false
                    } done: {
                        isShowing = false
                        
                        withAnimation {
                            //                            draft.commit(context: viewContext)
                        }
                    }
                }
        }
    }
    
    private var addItemButton: some View {
        Button {
            draft.items.append(RequestItemDraft())
        } label: {
            HStack {
                Image(systemName: "plus")
                Text(.newRequestItemAddButtonLabel)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: Metrics.cornerRadius).stroke(Color.blue))
        }
    }
    
    private var form: some View {
        List {
            Section {
                RecipientRow(text: $draft.recipient)
                DatePicker(LocalizedStringKey("DATE_PICKER_LABEL"), selection: $draft.date)
                Toggle(LocalizedStringKey("IS_RECURRING_TOGGLE_TITLE"), isOn: $draft.isRecurring)
            }
            
            Section(header: itemsSectionHeader) {
                ForEach(draft.items) { itemDraft in
                    NewRequestItemView(requestDraft: draft, itemDraft: itemDraft)
                }
                
                if !draft.items.contains { $0.literatureItem == nil } {
                    addItemButton
                }
            }
        }
    }
    
}

struct NewRequestView_Previews: PreviewProvider {
    
    @State private static var isShowing = true
    
    static var previews: some View {
        NewRequestView(isShowing: $isShowing)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
}
