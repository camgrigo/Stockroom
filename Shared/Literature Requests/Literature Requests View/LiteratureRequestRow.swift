//
//  LiteratureRequestRow.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

struct LiteratureRequestRow: View {
    
    @Environment(\.grouping) var grouping
    
    let request: LiteratureRequest
    
    @Environment(\.colorScheme) var colorScheme
    
    private func itemComponent(count: Int, title: String) -> some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title).font(.headline)
                Text("\(count)")
                    .font(Font.system(.footnote, design: .rounded).weight(.heavy))
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .foregroundColor(.background(colorScheme: colorScheme))
                .background(Color.primary.cornerRadius(20))
        }
    }
    
    private var columns: [GridItem] {
        switch grouping {
        case .requestDate:
            return [GridItem()]
        case .recipient:
            return [GridItem(), GridItem(.adaptive(minimum: 50))]
        case .item:
            return [GridItem(), GridItem()]
        }
    }
    
    var body: some View {
        VStack {
            Text("Request")
//            ForEach(request.items!, id: \.self) { order in
//                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
//                    if grouping != .item {
//                        itemComponent(count: Int(order.quantity), title: order.item!.title!)
//                    }
//                    if grouping != .recipient {
//                        Text(order.recipient!)
//                    }
//                    if grouping != .requestDate {
//                        Text("\(request.date!, formatter: LiteratureRequest.dateFormatter)")
//                    }
//                }
//            }
        }
        .padding()
    }
    
}

//struct OrderRow_Previews: PreviewProvider {
//
//    static let managedObjectContext = PersistenceController.preview.container.viewContext
//
//    static var previews: some View {
//        LiteratureRequestRow(order: try! managedObjectContext.fetch(LiteratureRequest.fetchRequest()).first!)
//            .environment(\.grouping, OrdersView.Grouping.requestDate)
//            .previewLayout(.fixed(width: 400, height: 120))
//    }
//}
