//
//  Badge.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/4/20.
//

import SwiftUI

struct Badge: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    
    let text: Text
    
    
    @State private var cornerRadius: CGFloat = 10
    
    @State private var backgroundColor: Color = {
        #if os(iOS)
        return Color(.secondarySystemFill)
        #else
        return Color.secondary
        #endif
    }()
    
    
    private let font = Font.system(.subheadline, design: .rounded).weight(.heavy)
    
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.3)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .cornerRadius(cornerRadius)
        .aspectRatio(1, contentMode: .fill)
    }
    
    var body: some View {
        switch colorScheme {
        case .dark:
            text
                .font(font)
                .shadow(radius: 4)
                .padding(4)
                .background(background)
        default:
            text
                .font(font)
                .padding(4)
                .background(background)
        }
    }
    
    func backgroundColor(_ color: Color) -> some View {
        self.backgroundColor = color
        
        return self
    }
    
    func cornerRadius(_ value: CGFloat) -> some View {
        self.cornerRadius = value
        
        return self
    }
    
    
    init(text: () -> Text) {
        self.text = text()
    }
    
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
                ZStack {
                    Badge { Text("Badge") }
                        .padding()
                    Rectangle()
                }
                .environment(\.colorScheme, colorScheme)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
