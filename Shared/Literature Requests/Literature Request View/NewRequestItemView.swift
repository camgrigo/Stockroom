//
//  NewRequestItemView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/12/20.
//

import SwiftUI

struct NewRequestItemView: View {
    
    @State private var isShowingItemPicker = true

    private var interval: Int {
        Int(itemDraft.literatureItem?.category?.quantityPerGrouping ?? 1) // TODO: Force unwrap once category work is finished
    }
    
    @ObservedObject var requestDraft: LiteratureRequestDraft
    
    let itemDraft: RequestItemDraft
    
    private var draftIndex: Int {
        requestDraft.items
            .firstIndex { $0.literatureItem == itemDraft.literatureItem }!
    }
    
    
    var body: some View {
        if isShowingItemPicker {
            LiteratureItemPicker(isShowingItemPicker: $isShowingItemPicker, draft: itemDraft)

        } else {
            QuantityStepper(value: $requestDraft.items[draftIndex].quantity, step: interval)
        }
    }
    
}
