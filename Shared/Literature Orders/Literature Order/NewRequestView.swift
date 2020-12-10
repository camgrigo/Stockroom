//
//  NewRequestView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI
import CoreData

struct NewRequestViewToolbar: ToolbarContent {
    
    @Binding var isShowing: Bool
    
    var formIsValid: Bool
    
    let done: () -> Void
    
    
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

struct NewRequestView: View {
    
    @Binding var isShowing: Bool
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var draft = LiteratureRequestDraft()
    
    private var isValid: Bool {
//        !draft.orders.isEmpty
        false
    }

    
    private let navigationTitle = "New Request"
    
    @State private var isShowingItemPicker = true
    
    
    var body: some View {
        NavigationView {
            form
                .navigationTitle(navigationTitle)
                .toolbar {
                    NewRequestViewToolbar(isShowing: $isShowing, formIsValid: isValid, done: done)
                }
        }
    }
    
    private var form: some View {
        Form {
            Section {
                DatePicker("Date", selection: $draft.date)
                RecipientRow(text: $draft.recipient)
                Toggle("Repeats Every Month", isOn: $draft.isRecurring)
            }
//            Section {
//                Button {
//                    withAnimation {
//                        isShowingItemPicker.toggle()
//                    }
//                } label: {
//                    HStack {
//                        if let item = orderDraft.literatureItem {
//                            LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
//                                .foregroundColor(.primary)
//                        } else {
//                            Text(isShowingItemPicker ? "Close" : "Choose Item…")
//                        }
//                        Spacer()
//                        Image(systemName: "chevron.right")
//                            .rotationEffect(isShowingItemPicker ? .degrees(90) : .degrees(.zero))
//                            .foregroundColor(.secondary)
//                    }
//                }
//
//                if isShowingItemPicker {
//                    LiteratureItemPicker(isShowingItemPicker: $isShowingItemPicker, orderDraft: orderDraft)
//                }
//
//                QuantityStepper(value: $orderDraft.quantity, step: orderDraft.interval)
//            }
        }
    }
    
    private func done() {
        withAnimation {
            draft.commit(context: viewContext)
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
        NewRequestView(isShowing: $isShowing)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
    
}
