//
//  Macros.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/22/20.
//

import SwiftUI

extension View {
    
    func iOS<T: View>(_ modifier: (Self) -> T) -> T {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
}
