//
//  ItemOptionsSection.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/28/20.
//

import SwiftUI

struct LiteratureItemPicker: View {
    
    @Binding var isShowingItemPicker: Bool
    
    @ObservedObject var draft: RequestItemDraft
    
    
    @FetchRequest(
        entity: LiteratureItem.entity(),
        sortDescriptors: [],
        animation: .default
    )
    private var literatureItems: FetchedResults<LiteratureItem>
    
    
    @State private var isShowingNewItemSheet = false
    
    
    private var picker: some View {
        List {
            ForEach(literatureItems) { item in
                Button {
                    withAnimation {
                        draft.literatureItem = item
                        isShowingItemPicker = false
                    }
                } label: {
                    HStack {
                        LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
                            .foregroundColor(.primary)
                        Spacer()
                        if item == draft.literatureItem {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
    
    private var addButton: some View {
        Button {
            withAnimation {
                isShowingNewItemSheet = true
            }
        } label: {
            if isShowingNewItemSheet {
                NewLiteratureItemForm(isShowing: $isShowingNewItemSheet)
                
            } else {
                Label(LocalizedStringKey("NEW_LITERATURE_ITEM_FORM_TITLE"), systemImage: "rectangle.badge.plus")
            }
        }
    }
    
    var body: some View {
        literatureItems.isEmpty ? AnyView(addButton) : AnyView(picker)
    }
    
}
