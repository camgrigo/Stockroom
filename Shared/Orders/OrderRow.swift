//
//  OrderRow.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

class OrderRowViewModel: NSObject {
    
    let title: String?
    
    let subtitle: String?
    
    let quantityString: String?
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    
    init(title: String?, subtitle: String?, quantityString: String?) {
        self.title = title
        self.subtitle = subtitle
        self.quantityString = quantityString
    }
    
    init(_ order: LiteratureOrder) {
        self.title = order.item?.title
        
        if let date = order.date {
            self.subtitle = dateFormatter.string(from: date)
            
        } else {
            self.subtitle = nil
        }
        
        self.quantityString = String(order.quantity)
    }
    
}

struct OrderRow: View {
    
    let model: OrderRowViewModel
    
    
    private var backgroundColor: Color {
        #if os(iOS)
        return Color(.secondarySystemFill)
        #else
        return Color.secondary
        #endif
    }
    
    var body: some View {
        HStack {
            Text(model.quantityString ?? String())
                .font(
                    Font.system(.title, design: .rounded)
                        .weight(.bold)
                )
                .padding(8)
                .background(
                    backgroundColor
                        .cornerRadius(10)
                        .aspectRatio(1, contentMode: .fill)
                )
                .padding(.trailing, 8)
            VStack(alignment: .leading) {
                Text(model.title ?? String())
                    .font(.headline)
                Text(model.subtitle ?? String())
            }
            Spacer()
        }
        .padding()
    }
    
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(model: OrderRowViewModel(title: "Suffering Tracts", subtitle: "Dec 10, 2020 at 9:45 AM", quantityString: "256"))
            .previewLayout(.fixed(width: 400, height: 120))
    }
}
