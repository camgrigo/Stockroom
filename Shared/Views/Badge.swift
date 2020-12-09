//
//  Badge.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/4/20.
//

import SwiftUI

struct ShadowTextStyle: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var shadowColor: Color {
        switch colorScheme {
        case .dark:
            return .black
            
        default:
            return .white
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(
                Font.system(.subheadline, design: .rounded)
                    .weight(.heavy)
            )
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .shadow(color: shadowColor, radius: 4)
    }
    
}

extension View {
    
    func shadowTextStyle() -> some View {
        self.modifier(ShadowTextStyle())
    }
    
}

//struct Badge_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
//                ZStack {
//                    Badge { Text("Badge") }
//                        .background(GradientBadgeBackground(color: .blue))
//                        .padding()
//                    Rectangle()
//                }
//                .environment(\.colorScheme, colorScheme)
//            }
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
