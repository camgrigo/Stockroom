//
//  IconPicker.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

struct Metrics {
    
    static let cornerRadius: CGFloat = 10
    
}

struct IconPicker: View {
    
    @Environment (\.colorScheme) var colorScheme
    
    
    let icons: [LiteratureItem.Icon]
    
    @Binding var selection: LiteratureItem.Icon
    
    private let columns = Array.init(repeating: GridItem(), count: 4)
    
    private var backgroundColor: Color {
        Color.primary.opacity(0.1)
    }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(icons, id: \.self) { icon in
                IconPickerButton(icon: icon, isSelected: selection == icon) {
                    selection = icon
                }
            }
        }
        .padding()
        .background(backgroundColor.cornerRadius(Metrics.cornerRadius + 10))
    }
    
}

extension IconPicker {
    
    struct IconPickerButton: View {
        
        @Environment (\.colorScheme) var colorScheme

        
        let icon: LiteratureItem.Icon
        
        let isSelected: Bool
        
        let action: () -> Void
        
        
        private var foregroundColor: Color {
            #if os(iOS)
            return Color(isSelected ? .white : .label)
            #else
            return isSelected ? .white : .primary
            #endif
        }
        
        private var backgroundColor: Color {
            #if os(iOS)
            return isSelected ? .blue : Color(.systemBackground)
            #else
            if isSelected { return .blue }
            
            switch colorScheme {
            case .dark:
                return .black
                 
            default:
                return .white
            }
            #endif
        }
        
        var body: some View {
            Button(action: action) {
                HStack {
                    Spacer()
                    Image(systemName: isSelected ? icon.fill : icon.rawValue)
                        .font({
                            #if os(macOS)
                            return Font.body
                            #else
                            return Font.title
                            #endif
                        }())
                        .padding(10)
                    Spacer()
                }
            }
            .foregroundColor(isSelected ? .white : .primary)
            .background(backgroundColor.cornerRadius(Metrics.cornerRadius))
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
