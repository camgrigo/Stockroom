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

struct NewRequestViewToolbar: ToolbarContent {
    
    @Binding var isShowing: Bool
    
    var formIsValid: Bool
    
    let done: () -> Void
    
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel_Button_Title") {
                isShowing = false
            }
        }
        
        ToolbarItem(placement: .confirmationAction) {
            Button("Done_Button_Title") {
                isShowing = false
                done()
            }
            .disabled(!formIsValid)
        }
    }
    
}

struct NewRequestView: View {
    
    @Binding var isShowing: Bool
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var draft = LiteratureRequestDraft()
    
    private var isValid: Bool {
        !draft.items.isEmpty && draft.items.allSatisfy { $0.literatureItem != nil }
    }

    
    var body: some View {
        NavigationView {
            form
                .navigationTitle(Text(LocalizedStringKey("New_Request_View_Navigation_Title")))
                .toolbar {
                    NewRequestViewToolbar(isShowing: $isShowing, formIsValid: isValid, done: done)
                }
        }
    }
    
    private var form: some View {
        Form {
            Section {
                RecipientRow(text: $draft.recipient)
                DatePicker(LocalizedStringKey("Date_Picker_Label"), selection: $draft.date)
                Toggle(LocalizedStringKey("Is_Recurring_Toggle_Title"), isOn: $draft.isRecurring)
            }
            ForEach(draft.items) { itemDraft in
                Section(header: Text(itemDraft.literatureItem?.title ?? "Item")) {
                    NewRequestItemView(requestDraft: draft, itemDraft: itemDraft)
                }
            }
            if !draft.items.contains { $0.literatureItem == nil } {
                Section {
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
            }
        }
    }
    
    private func done() {
        withAnimation {
//            draft.commit(context: viewContext)
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
