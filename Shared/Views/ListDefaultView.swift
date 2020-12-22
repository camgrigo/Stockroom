//
//  ListDefaultView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/16/20.
//

import SwiftUI

struct ListDefaultView<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    
    let text: Text
    
    let action: () -> Void
    
    let image: Content
    
    
    init(description: String, action: @escaping () -> Void, image: () -> Content) {
        self.text = Text(description)
        self.action = action
        self.image = image()
    }
    
    init(descriptionKey: LocalizedStringKey, action: @escaping () -> Void, image: () -> Content) {
        self.text = Text(descriptionKey)
        self.action = action
        self.image = image()
    }
    
    
    private let imageFont = Font.system(size: 80).weight(.light)
    
    private var imageGradient: Gradient {
        switch colorScheme {
        case .dark:
            return Gradient(colors: [Color(#colorLiteral(red: 0.09791759402, green: 0.5348291993, blue: 0.3856037557, alpha: 1)), Color(#colorLiteral(red: 0.04659470916, green: 0.1764925718, blue: 0.3244509697, alpha: 1))])
        default:
            return Gradient(colors: [Color(#colorLiteral(red: 0.1434419498, green: 0.783484765, blue: 0.5648806541, alpha: 1)), Color(#colorLiteral(red: 0.1044869397, green: 0.3957781695, blue: 0.7275694925, alpha: 1))])
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack {
                image
                    .font(imageFont)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .padding(30)
                    .background(
                        Circle()
                            .fill(
                                LinearGradient(gradient: imageGradient, startPoint: .topTrailing, endPoint: .bottomLeading)
                            )
                            .aspectRatio(1, contentMode: .fill)
                    )
                    .padding(.bottom)
                text
                    .font(Font.title3.weight(.medium))
                    .foregroundColor(foregroundColor)
                    .multilineTextAlignment(.center)
            }
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
        ListDefaultView(description: "Get Started", action: {}) {
            Image(systemName: "books.vertical.fill")
        }
    }
}
