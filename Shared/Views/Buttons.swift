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

struct RoundedButtonStyle: ViewModifier {
    
    let color: Color
    
    init(color: Color = Color.secondary.opacity(0.2)) {
        self.color = color
    }
    
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(color.cornerRadius())
    }
    
}

extension View {
    
    func roundedStyle() -> some View {
        self.modifier(RoundedButtonStyle())
    }
    
}
