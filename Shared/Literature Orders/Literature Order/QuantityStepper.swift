//
//  QuantityStepper.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/28/20.
//

import SwiftUI

struct QuantityStepper: View {
    
    @ObservedObject var orderDraft: OrderDraft
    
    private let range = 1...Int(Int32.max - 1)
    
    
    var body: some View {
        Stepper(value: $orderDraft.quantity, in: range, step: orderDraft.interval) {
            TextField(
                "Quantity",
                text: Binding {
                    String(orderDraft.quantity)
                } set: {
                    if let newValue = Int($0),
                       range.contains(newValue) {
                        orderDraft.quantity = newValue
                    }
                }
            )
        }
    }
    
}

//struct QuantityStepper_Previews: PreviewProvider {
//    static var previews: some View {
//        QuantityStepper()
//    }
//}
