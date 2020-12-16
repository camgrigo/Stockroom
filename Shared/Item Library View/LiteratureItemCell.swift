//
//  LiteratureItemCell.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/17/20.
//

import SwiftUI

struct LiteratureItemCell: View {
    
    let model: LiteratureItemCellViewModel
    
    
    private var mainColor: Color {
        #if os(iOS)
        return Color(.label)
        #else
        return Color.primary
        #endif
    }
    
    var body: some View {
        HStack {
            Image(systemName: model.icon)
                .foregroundColor(mainColor)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(mainColor, lineWidth: 2)
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 40)
                )
                .padding(.trailing, 8)
            Text(model.title)
            Spacer()
        }
        .padding(.vertical)
    }
    
}

struct LiteratureItemCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
                LiteratureItemCell(model: LiteratureItemCellViewModel(icon: LiteratureItem.Icon.default.rawValue, title: LiteratureItem.defaultTitle))
                    .environment(\.colorScheme, colorScheme)
            }
        }
            .previewLayout(.fixed(width: 175, height: 100))
    }
}
