//
//  NumberField.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/28/20.
//

import SwiftUI

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
