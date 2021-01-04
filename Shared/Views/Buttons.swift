//
//  Buttons.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/29/20.
//

import SwiftUI

struct AddButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
        }
    }
    
}
