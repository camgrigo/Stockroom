//
//  OrdersListViews.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/5/20.
//

import SwiftUI

struct OverscrollSpacer: View {
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear.frame(height: geometry.size.height * 0.5)
        }
    }
    
}

struct OrdersListSection<Content: View>: View {
    
    @Environment(\.grouping) var grouping
    
    let section: (title: String, items: [LiteratureOrder])
    
    let content: Content
    
    var body: some View {
        Section {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text(section.title).font(.headline)
                if grouping != .item {
                    Badge { Text("\(section.items.count)") }
                        .padding(.trailing, 6)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            content
        }
    }
    
    
    init(section: (title: String, items: [LiteratureOrder]), content: () -> Content) {
        self.section = section
        self.content = content()
    }
    
}
