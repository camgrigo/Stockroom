//
//  QuantityStepper.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/28/20.
//

import SwiftUI

struct QuantityStepper: View {
    
    @Binding var value: Int
    
    let step: Int
    
    
    private let label: LocalizedStringKey = "QUANTITY_LABEL"
    
    private let range = 1...Int(Int32.max - 1)
    
    
    private func textBinding() -> Binding<String> {
        Binding {
            String(value)
        } set: {
            if let newValue = Int($0),
               range.contains(newValue) {
                value = newValue
            }
        }
    }
    
    
    var body: some View {
        Stepper(value: $value, in: range, step: step) {
            HStack {
                Text(label)
                TextField(label, text: textBinding())
            }
        }
    }
    
}
