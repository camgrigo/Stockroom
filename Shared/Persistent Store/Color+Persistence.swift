//
//  Color+Persistence.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/15/20.
//

import SwiftUI

// https://developer.apple.com/forums/thread/653639

#if os(iOS)
import UIKit
#endif
#if os(macOS)
import Foundation
#endif

extension LiteratureItem {
    
    private struct ColorData: Codable {
        var r: Double
        var g: Double
        var b: Double
        var a: Double
    }
    
    static let defaultColor = Color.blue
    
    var color: Color {
        get {
            guard
                let colorData = colorData,
                let decoded = try? JSONDecoder().decode(ColorData.self, from: colorData)
            else { return LiteratureItem.defaultColor }
            return Color(.sRGB, red: decoded.r, green: decoded.g, blue: decoded.b, opacity: decoded.a)
        }
        set {
            #if os(iOS)
            let nativeColor = UIColor(newValue)
            #elseif os(macOS)
            let nativeColor = NSColor(newValue)
            #endif
            
            var (r, g, b, a) = (CGFloat.zero, CGFloat.zero, CGFloat.zero, CGFloat.zero)
            nativeColor.getRed(&r, green: &g, blue: &b, alpha: &a)
            if let encoded = try? JSONEncoder().encode(ColorData(r: Double(r), g: Double(g), b: Double(b), a: Double(a))) {
                colorData = encoded
            } else {
                colorData = nil
            }
        }
    }
    
}
