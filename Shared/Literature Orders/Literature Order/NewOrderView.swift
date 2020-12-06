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
                done()
                isShowing = false
            }
            .disabled(!formIsValid)
        }
    }
    
}

struct NewOrderView: View {
    
    enum Mode {
        case itemPicker, orderEditor
    }
    
    
    @Binding var isShowing: Bool
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var orderDraft = OrderDraft()
    
    
    private let navigationTitle = "Record An Order"
    
    @State private var mode = Mode.itemPicker
    
    var body: some View {
        NavigationView {
            VStack {
                if mode == .itemPicker {
                    LiteratureItemPicker(mode: $mode, orderDraft: orderDraft)
                        .opacity(mode == .itemPicker ? 1 : 0)
                }
                if mode == .orderEditor {
                    form
                        .opacity(mode == .orderEditor ? 1 : 0)
                }
                Spacer()
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                NewOrderViewToolbar(isShowing: $isShowing, formIsValid: orderDraft.isValid, done: done)
            }
        }
    }
    
    private var form: some View {
        Form {
            Section {
                Button {
                    withAnimation {
                        mode = .itemPicker
                    }
                } label: {
                    if let item = orderDraft.literatureItem {
                        HStack {
                                LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
                                    .foregroundColor(.primary)
                                Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                        }
                        
                    } else {
                        Text("Choose item…")
                    }
                }
                QuantityStepper(orderDraft: orderDraft)
            }
            Section {
                DatePicker("Date", selection: $orderDraft.date)
                HStack {
                    Text("Recipient")
                        .font(.headline)
                        .padding(.trailing)
                    #if os(iOS)
                    TextField("Name", text: $orderDraft.recipient)
                        .autocapitalization(.words)
                    #else
                    TextField("Name", text: $orderDraft.recipient)
                    #endif
                }
                Toggle("Standing Request", isOn: $orderDraft.isRecurring)
            }
        }
    }
    
    private func done() {
        withAnimation {
            _ = orderDraft.managedObject(context: viewContext)
            PersistenceController.save(viewContext)
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
