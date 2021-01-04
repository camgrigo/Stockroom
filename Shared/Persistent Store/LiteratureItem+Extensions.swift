//
//  LiteratureItem+Extensions.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/24/20.
//

import Foundation

extension LiteratureItem {
    
    static let defaultTitle = "No Title"
    
    enum Icon: String, Hashable, CaseIterable {
        case book = "book"
        case bookClosed = "book.closed"
        case textBookClosed = "text.book.closed"
        case rectangeOnRectangle = "rectangle.on.rectangle"
        case docPlaintext = "doc.plaintext"
        
        static var `default`: Icon { .book }
        
        var fill: String {
            switch self {
            case .rectangeOnRectangle:
                return "rectangle.fill.on.rectangle.fill"
                
            default:
                return rawValue + ".fill"
            }
        }
    }
    
}

extension LiteratureItem: Identifiable {}
