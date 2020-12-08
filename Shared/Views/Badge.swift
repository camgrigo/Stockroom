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
    
    let cornerRadius: CGFloat
    
    let color: Color
    
    
    init (color: Color? = nil, cornerRadius: CGFloat = 10, text: () -> Text) {
        self.color = color ?? {
            #if os(iOS)
            return Color(.secondarySystemFill)
            #else
            return Color.secondary
            #endif
        }()
        self.cornerRadius = cornerRadius
        self.text = text()
    }
    
    
    private let font = Font.system(.subheadline, design: .rounded).weight(.heavy)
    
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [color, color.opacity(0.3)]),
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
