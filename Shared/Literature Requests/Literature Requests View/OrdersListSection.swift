//
//  OrdersListSection.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/5/20.
//

import SwiftUI

struct OrdersListSection<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.grouping) var grouping
    
    let section: (title: String, items: [LiteratureRequest])
    
    let content: Content
    
    private var backgroundColor: Color {
        #if os(iOS)
        return Color(.systemBackground)
        #else
        return colorScheme == .dark ? .black : .white
        #endif
    }
    
    var body: some View {
        Section {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text(section.title).font(.title3)
                if grouping != .item && section.items.count > 1 {
                    Text("\(section.items.count) Orders")
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            content
        }
    }
    
    
    init(section: (title: String, items: [LiteratureRequest]), content: () -> Content) {
        self.section = section
        self.content = content()
    }
    
}
