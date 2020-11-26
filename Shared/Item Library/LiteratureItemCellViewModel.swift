//
//  LiteratureItemCellViewModel.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/24/20.
//

import Foundation

struct LiteratureItemCellViewModel {
    
    let icon: String
    let title: String
     
    init(literatureItem: LiteratureItem) {
        self.init(icon: literatureItem.icon!, title: literatureItem.title!)
    }
    
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
    
}
