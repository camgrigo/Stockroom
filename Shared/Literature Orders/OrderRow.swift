//
//  OrderRow.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

struct OrderRow: View {
    
    let model: OrderRowViewModel
    
    let grouping: OrdersView.Grouping
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                if grouping != .item {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Badge {
                            Text(model.quantityString)
                        }
                        .backgroundColor(.blue)
                        Text(model.title)
                    }
                }
                HStack {
                    if grouping != .recipient {
                        Text(model.subtitle)
                            .font(.headline)
                    }
                    if grouping != .requestDate {
                        Text(model.detail)
                            .font(Font.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
    
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(
            model: OrderRowViewModel(
                title: "Suffering Tracts",
                subtitle: "Steve Jones",
                detail: "12/10/2020",
                quantityString: "256"
            ),
            grouping: .requestDate
        )
        .previewLayout(.fixed(width: 400, height: 120))
    }
}
