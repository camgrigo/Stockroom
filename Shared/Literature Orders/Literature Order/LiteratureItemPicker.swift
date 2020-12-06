//
//  ItemOptionsSection.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/28/20.
//

import SwiftUI

struct LiteratureItemPicker: View {
    
    @Binding var isShowingItemPicker: Bool
    
    @ObservedObject var orderDraft: OrderDraft
    
    
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
                        orderDraft.literatureItem = item
                        isShowingItemPicker = false
                    }
                } label: {
                    HStack {
                        LiteratureItemCell(model: LiteratureItemCellViewModel(literatureItem: item))
                            .foregroundColor(.primary)
                        Spacer()
                        if item == orderDraft.literatureItem {
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
            isShowingNewItemSheet = true
        } label: {
            Label("Add Literature Item", systemImage: "plus")
        }
        .sheet(isPresented: $isShowingNewItemSheet) {
            NewLiteratureItemView(isShowing: $isShowingNewItemSheet)
        }
    }
    
    var body: some View {
        literatureItems.count > 0 ? AnyView(picker) : AnyView(addButton)
    }
    
}
