//
//  NewRequestView+RecipientRow.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/12/20.
//

import SwiftUI

extension NewRequestView {
    
    struct RecipientRow: View {
        
        @Binding var text: String
        
        var body: some View {
            HStack(spacing: 12) {
                Text("Name_Text_Field_Title")
                
                #if os(iOS)
                TextField(LocalizedStringKey("Name_Text_Field_Description"), text: $text)
                    .autocapitalization(.words)
                #else
                TextField(LocalizedStringKey("Name_Text_Field_Description"), text: $text)
                #endif
            }
        }
        
    }
    
}
