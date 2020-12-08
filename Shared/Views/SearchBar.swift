//
//  SearchBar.swift
//  Meeting Assignments (iOS)
//
//  Created by Cameron Grigoriadis on 9/25/20.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    
    private var backgroundColor: Color {
        #if os(iOS)
        return Color(UIColor.tertiarySystemFill)
        #else
        return Color.secondary
        #endif
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search", text: $text)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(backgroundColor.cornerRadius(12))
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    
    @State private static var text = "Test"
    
    static var previews: some View {
        SearchBar(text: $text)
            .previewLayout(.sizeThatFits)
    }
    
}
