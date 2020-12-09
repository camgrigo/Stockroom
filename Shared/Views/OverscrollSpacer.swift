//
//  OverscrollSpacer.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/8/20.
//

import SwiftUI

struct OverscrollSpacer: View {
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear.frame(height: geometry.size.height * 0.5)
        }
    }
    
}
