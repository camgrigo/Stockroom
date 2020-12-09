//
//  OrderRow.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/18/20.
//

import SwiftUI

extension Color {
    
    static var secondarySystemFill: Color {
        #if os(iOS)
        return Color(.secondarySystemFill)
        #else
        return Color.secondary
        #endif
    }
    
    static func background(colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .dark:
            return .black
        default:
            return .white
        }
    }
    
}

struct OrderRow: View {
    
    @Environment(\.grouping) var grouping
    
    let order: LiteratureOrder
    
    @Environment(\.colorScheme) var colorScheme
    
    private func itemComponent(count: Int, title: String) -> some View {
        HStack(spacing: 8) {
            Text(title).font(.headline)
            Text("\(count)")
                .font(Font.system(.footnote, design: .rounded).weight(.heavy))
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .foregroundColor(.background(colorScheme: colorScheme))
                .background(Color.primary.cornerRadius(20))
        }
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200)), GridItem()], alignment: .leading, spacing: 10) {
            if grouping != .item {
                itemComponent(count: Int(order.quantity), title: order.item!.title!)
            }
            if grouping != .recipient {
                Text(order.recipient!)
            }
            if grouping != .requestDate {
                Text("\(order.date!, formatter: LiteratureOrder.dateFormatter)")
            }
        }
        .padding()
    }
    
}

struct OrderRow_Previews: PreviewProvider {
    
    static let managedObjectContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        OrderRow(order: try! managedObjectContext.fetch(LiteratureOrder.fetchRequest()).first!)
            .environment(\.grouping, OrdersView.Grouping.requestDate)
            .previewLayout(.fixed(width: 400, height: 120))
    }
}
