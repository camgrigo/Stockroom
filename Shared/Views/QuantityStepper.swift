//
//  QuantityStepper.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/28/20.
//

import SwiftUI

struct QuantityStepper: View {
    
    let title = "Quantity"
    
    @Binding var value: Int
    
    let step: Int
    
    private let range = 1...Int(Int32.max - 1)
    
    
    var body: some View {
        Stepper(value: $value, in: range, step: step) {
            TextField(title,
                text: Binding {
                    String(value)
                } set: {
                    if let newValue = Int($0),
                       range.contains(newValue) {
                        value = newValue
                    }
                }
            )
        }
    }
    
}
