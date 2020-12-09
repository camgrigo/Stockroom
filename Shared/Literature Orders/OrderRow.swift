//
//  OrderRow.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

struct OrderRow: View {

    @Environment(\.grouping) var grouping
    
    let order: LiteratureOrder
    
    private func itemComponent(count: Int, title: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Badge(color: .blue) {
                Text("\(count)")
            }
            Text(title)
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                if grouping != .item {
                    itemComponent(count: Int(order.quantity), title: order.item!.title!)
                }
                HStack {
                    if grouping != .recipient {
                        Text(order.recipient!)
                        Spacer()
                    }
                    if grouping != .requestDate {
                        Text("\(order.date!, formatter: LiteratureOrder.dateFormatter)")
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
    
}

//struct OrderRow_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderRow(
//            model: OrderRowViewModel(
//                title: "Suffering Tracts",
//                subtitle: "Steve Jones",
//                detail: "12/10/2020",
//                quantityString: "256"
//            ),
//            grouping: .requestDate
//        )
//        .previewLayout(.fixed(width: 400, height: 120))
//    }
//}
