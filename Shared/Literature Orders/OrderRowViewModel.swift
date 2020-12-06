//
//  OrderRowViewModel.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/29/20.
//

import Foundation

class OrderRowViewModel: NSObject {
    
    let title: String
    
    let subtitle: String
    
    let detail: String
    
    let quantityString: String
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    
    init(title: String, subtitle: String, detail: String, quantityString: String) {
        self.title = title
        self.subtitle = subtitle
        self.detail = detail
        self.quantityString = quantityString
    }
    
    init(_ order: LiteratureOrder) {
        self.title = order.item?.title ?? String()
        
        self.subtitle = order.recipient ?? String()
        
        if let date = order.date {
            self.detail = dateFormatter.string(from: date)
            
        } else {
            self.detail = String()
        }
        
        self.quantityString = String(order.quantity)
    }
    
}
