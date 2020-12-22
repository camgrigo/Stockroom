//
//  Metrics.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/19/20.
//

import SwiftUI

struct Metrics {
    static let cornerRadius: CGFloat = 10
}

extension View {
    
    func cornerRadius() -> some View {
        self.cornerRadius(Metrics.cornerRadius)
    }
    
}
