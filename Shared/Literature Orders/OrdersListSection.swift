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
    
    let section: (title: String, items: [LiteratureOrder])
    
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
                Text(section.title).font(.headline)
                if grouping != .item {
                    Text("\(section.items.count)")
                        .shadowTextStyle()
                        .background(Color.secondarySystemFill)
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
