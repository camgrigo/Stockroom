//
//  LiteratureItemPicker.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/20/20.
//

import SwiftUI

//struct LiteratureItemPicker: View {
//
//    var body: some View {
//        Form {
//            Picker("Item", selection: <#T##Binding<_>#>) {
//                <#code#>
//            }
//        }
//    }
//
//}

//struct LiteratureItemPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        LiteratureItemPicker()
//    }
//}

//final class LiteratureItemPickerCell : UIViewController {
    
//    private var formItemSection: some View {
//        Section {
//            if let itemTitle = literatureItem?.title {
//                Text(itemTitle)
//            }
//            Picker(literatureItem?.title ?? "Item", selection: $literatureItem) {
//                ForEach(literatureItems) { item in
//                    LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
//                }
//            }
//            HStack {
//                Text("Quantity")
//                NumberField(title: "Quantity", text: $quantity)
//                Stepper("Quantity") {
//                    quantity = String(Int(quantity)! + increment)
//                } onDecrement: {
//                    quantity = String(Int(quantity)! - increment)
//                }
//                .labelsHidden()
//            }
//            HStack {
//                Text("Increment By")
//                NumberField(title: "Amount", text: Binding { String(increment) } set: { increment = Int($0) ?? 1 })
//                Stepper("Amount", value: $increment, in: 1...500)
//                    .labelsHidden()
//            }
//        }
//    }
    
//}
