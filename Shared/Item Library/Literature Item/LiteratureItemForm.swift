//
//  LiteratureItemForm.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/3/20.
//

import SwiftUI

struct LiteratureItemForm: View {
    
    @Binding var title: String
    
    @Binding var icon: LiteratureItem.Icon
    
    
    private let itemTitleFont = Font.title.weight(.medium)
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                #if os(iOS)
                TextField("Title", text: $title)
                    .font(itemTitleFont)
                    .autocapitalization(.words)
                #else
                TextField("Title", text: $title)
                    .font(itemTitleFont)
                #endif
                VStack(alignment: .leading) {
                    Text("Icon")
                        .font(.headline)
                    IconPicker(icons: LiteratureItem.Icon.allCases, selection: $icon)
                }
                .padding(.top)
            }
            .padding()
        }
    }
    
}

struct LiteratureItemForm_Previews: PreviewProvider {
    @State private static var title = String()
    
    @State private static var icon = LiteratureItem.Icon.default
    
    static var previews: some View {
        LiteratureItemForm(title: $title, icon: $icon)
    }
}
