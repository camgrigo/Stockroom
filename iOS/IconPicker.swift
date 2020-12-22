//
//  IconPicker.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

struct IconPicker: View {
    
    let icons: [LiteratureItem.Icon]
    
    @Binding var selection: LiteratureItem.Icon
    
//    private let columns = Array.init(repeating: GridItem(), count: 4)
    
    private let label: LocalizedStringKey = "ICON_PICKER_LABEL"
    
    
    var body: some View {
        Picker(selection: $selection, label: Text(label)) {
            ForEach(icons, id: \.self) { icon in
                Image(systemName: icon.fill)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
//        LazyVGrid(columns: columns) {
//            ForEach(icons, id: \.self) { icon in
//                IconPickerButton(icon: icon, selection: $selection)
//            }
//        }
//        .mask(
//            RoundedRectangle(cornerRadius: Metrics.cornerRadius)
//        )
    }
    
}

extension IconPicker {
    
    struct IconPickerButton: View {
        
        @Environment (\.colorScheme) var colorScheme

        
        let icon: LiteratureItem.Icon
        
        @Binding var selection: LiteratureItem.Icon
        
        private var isSelected: Bool {
            selection == icon
        }
        
        
        private var backgroundColor: Color {
            isSelected ? .blue : Color(.systemBackground)
        }
        
        var body: some View {
            Button {
                selection = icon
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: isSelected ? icon.fill : icon.rawValue)
                        .font(.title)
                        .padding(10)
                    Spacer()
                }
            }
            .foregroundColor(isSelected ? .white : .blue)
            .background(backgroundColor)
        }
        
    }
    
}

struct IconPicker_Previews: PreviewProvider {
    
    static private var icons: [LiteratureItem.Icon] = [.book, .bookClosed, .textBookClosed, .rectangeOnRectangle, .docPlaintext]
    
    @State static private var selection = icons[0]
    
    static var previews: some View {
        IconPicker(icons: icons, selection: $selection)
            .frame(width: 400)
            .previewLayout(.fixed(width: 500, height: 250))
    }
    
}
