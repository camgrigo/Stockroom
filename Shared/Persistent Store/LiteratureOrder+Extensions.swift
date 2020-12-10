//
//  LiteratureRequest+Extensions.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/5/20.
//

import Foundation

extension LiteratureRequest {
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter
    }
    
}
