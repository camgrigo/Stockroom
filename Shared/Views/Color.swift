//
//  Color.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/10/20.
//

import SwiftUI

extension Color {
    
    static var secondarySystemFill: Color {
        #if os(iOS)
        return Color(.secondarySystemFill)
        #else
        return Color.secondary
        #endif
    }
    
    static func background(colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .dark:
            return .black
        default:
            return .white
        }
    }
    
}
