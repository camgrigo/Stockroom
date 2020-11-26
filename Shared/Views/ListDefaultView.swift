//
//  ListDefaultView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import SwiftUI

struct ListDefaultView: View {
    
    let text: String
    
    let action: () -> Void
    
    let image: Image
    
    
    init(text: String, action: @escaping () -> Void, image: () -> Image) {
        self.text = text
        self.action = action
        self.image = image()
    }
    
    
    let imageFont = Font.system(size: 80).weight(.light)
    
    var body: some View {
        Button(action: action) {
            VStack {
                image
                    .font(imageFont)
                    .padding(.bottom)
                Text(text)
                    .font(Font.title3.weight(.medium))
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(foregroundColor)
            .padding()
        }
        .buttonStyle(SquishableButtonStyle(fadeOnPress: true))
    }
    
    
    @State private var foregroundColor = Color.primary
    
    func foregroundColor(_ color: Color) -> some View {
        foregroundColor = color
        
        return self
    }
    
}

struct LiteratureItemsListDefaultView_Previews: PreviewProvider {
    static var previews: some View {
        ListDefaultView(text: "Get Started", action: {}) {
            Image(systemName: "books.vertical.fill")
        }
    }
}
