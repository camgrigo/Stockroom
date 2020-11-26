//
//  NewOrderView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI
import CoreData

struct NumberField: View {
    
    let title: String
    
    @Binding var text: String
    
    
    var body: some View {
        #if os(iOS)
        TextField(title, text: $text)
            .keyboardType(.numberPad)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(
                Color.secondary
                    .opacity(0.1)
                    .cornerRadius(8)
            )
        #else
        TextField(title, text: $text)
        #endif
    }
    
}

final class NewOrder: ObservableObject {
    
    @Published var date = Date()
    
    private var quantity = 1
    
    lazy var quantityString = {
        Binding {
            String(self.quantity)
        } set: {
            self.quantity = Int($0)!
        }
    }()
    
    @Published var literatureItem: LiteratureItem?
    
    var interval: Int {
        Int(literatureItem?.category?.quantityPerGrouping ?? 1)
    }
    
    @Published var recipient = String()
    
    @Published var isRecurring = false
    
    
    func incrementQuantity() {
        quantity += interval
    }
    
    func decrementQuantity() {
        quantity -= interval
    }
    
    func managedObject(context: NSManagedObjectContext) -> LiteratureOrder {
        let order = LiteratureOrder(context: context)
        
        order.date = date
        order.item = literatureItem
        order.quantity = Int32(quantity)
        order.recipient = recipient
        
        return order
    }
    
}

struct QuantityPicker: View {
    
    private let title = "Quantity"
    
    let onIncrement: () -> Void
    
    let onDecrement: () -> Void
    
    @Binding var quantityString: String
    
    
    var body: some View {
        #if os(iOS)
        HStack {
            Button(action: onIncrement) { Image(systemName: "plus") }
            TextField(title, text: $quantityString)
            Button(action: onDecrement) { Image(systemName: "minus") }
        }
        #else
        HStack {
            TextField(title, text: $quantityString)
            Stepper(title, onIncrement: onIncrement, onDecrement: onDecrement)
        }
        #endif
    }
    
}

struct NewOrderView: View {
    
    @Binding var isShowing: Bool
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: LiteratureItem.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var literatureItems: FetchedResults<LiteratureItem>
    
    @ObservedObject private var newOrder = NewOrder()
    
    
    @State private var isShowingNewItemSheet = false
    
    @State private var isShowingItemsSheet = false
    
    private var itemOptions: some View {
        if literatureItems.count > 0 {
            return AnyView (
                Group {
                    Section {
                        Picker("Item", selection: $newOrder.literatureItem) {
                            ForEach(literatureItems) { item in
                                Text(item.title!)
                            }
                        }
                        ItemsButton(isShowingItemsSheet: $isShowingItemsSheet)
                    }
                    Section(header: Text("Quantity")) {
                        HStack {
                            TextField("Quantity", text: newOrder.quantityString)
                            Stepper("Quantity", onIncrement: newOrder.incrementQuantity, onDecrement: newOrder.decrementQuantity)
                        }
                            .labelsHidden()
                    }
                }
            )
            
        } else {
            return AnyView(
                Section {
                    Button {
                        isShowingNewItemSheet = true }
                        label: {
                            Label("New Literature Item", systemImage: "book.closed")
                        }
                }
            )
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                    itemOptions
                Section {
                    DatePicker("Date", selection: $newOrder.date)
                    #if os(iOS)
                    TextField("Recipient", text: $newOrder.recipient)
                        .autocapitalization(.words)
                    #else
                    TextField("Recipient", text: $newOrder.recipient)
                    #endif
                    Toggle("Standing Request", isOn: $newOrder.isRecurring)
                }
            }
            .navigationTitle("Record An Order")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isShowing = false }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        done()
                        isShowing = false
                    }
                }
            }
            .sheet(isPresented: $isShowingNewItemSheet) {
                NewLiteratureItemView(isShowing: $isShowingNewItemSheet)
            }
        }
    }
    
    private func done() {
        withAnimation {
            _ = newOrder.managedObject(context: viewContext)
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
