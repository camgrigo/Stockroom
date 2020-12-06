//
//  NewOrderView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI
import CoreData

struct NewOrderViewToolbar: ToolbarContent {
    
    @Binding var isShowing: Bool
    
    var formIsValid: Bool
    
    let done: () -> Void
    
    @State private var isShowingItemLibrary = false
    
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
                isShowing = false
            }
        }
        
        ToolbarItem(placement: .confirmationAction) {
            Button("Done") {
                isShowing = false
                done()
            }
            .disabled(!formIsValid)
        }
    }
    
}

struct NewOrderView: View {
    
    @Binding var isShowing: Bool
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var orderDraft = OrderDraft()
    
    
    private let navigationTitle = "Record An Order"
    
    @State private var isShowingItemPicker = true
    
    
    var body: some View {
        NavigationView {
            form
                .navigationTitle(navigationTitle)
                .toolbar {
                    NewOrderViewToolbar(isShowing: $isShowing, formIsValid: orderDraft.isValid, done: done)
                }
        }
    }
    
    private var form: some View {
        Form {
            Section {
                DatePicker("Date", selection: $orderDraft.date)
                RecipientRow(text: $orderDraft.recipient)
                Toggle("Repeats Every Month", isOn: $orderDraft.isRecurring)
            }
            Section {
                Button {
                    withAnimation {
                        isShowingItemPicker.toggle()
                    }
                } label: {
                    HStack {
                        if let item = orderDraft.literatureItem {
                            LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
                                .foregroundColor(.primary)
                        } else {
                            Text(isShowingItemPicker ? "Close" : "Choose Item…")
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .rotationEffect(isShowingItemPicker ? .degrees(90) : .degrees(.zero))
                            .foregroundColor(.secondary)
                    }
                }

                if isShowingItemPicker {
                    LiteratureItemPicker(isShowingItemPicker: $isShowingItemPicker, orderDraft: orderDraft)
                }
                
                QuantityStepper(orderDraft: orderDraft)
            }
        }
    }
    
    private func done() {
        withAnimation {
            _ = orderDraft.managedObject(context: viewContext)
            PersistenceController.save(viewContext)
        }
    }
    
    
    struct RecipientRow: View {
        
        @Binding var text: String
        
        var body: some View {
            HStack(spacing: 12) {
                Text("Recipient")
                
                #if os(iOS)
                TextField("Name", text: $text).autocapitalization(.words)
                #else
                TextField("Name", text: $text)
                #endif
            }
        }
        
    }
    
}

struct NewOrderView_Previews: PreviewProvider {
    
    @State private static var isShowing = true
    
    static var previews: some View {
        NewOrderView(isShowing: $isShowing)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
}
