//
//  OrdersListViews.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/5/20.
//

import SwiftUI

struct OrdersListItemView: View {
    
    struct SectionHeader: View {
        
        let count: Int
        
        let title: String
        
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                Badge { Text("\(count)") }.padding(.trailing, 6)
                Text(title).font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        
    }
    
    struct Row: View {
        
        let subtitle: String
        
        let detail: String
        
        var body: some View {
            HStack {
                Text(subtitle)
                    .font(.headline)
                Spacer()
                Text(detail)
                    .font(Font.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        
    }
    
    let items: Dictionary<String, [LiteratureOrder]>
    
    var body: some View {
        ForEach(items.map { (title: $0, items: $1) }, id: \.title) { section in
            VStack {
                SectionHeader(count: section.items.count, title: section.title)
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(section.items) { order in
                        Row(subtitle: order.recipient ?? String(), detail: {
                            if let date = order.date {
                                return LiteratureOrder.dateFormatter.string(from: date)
                            }
                            
                            return String()
                        }())
                        .background(
                            Color.secondary
                                .opacity(0.2)
                                .cornerRadius(15)
                        )
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
}

struct OrdersListRecipientView: View {
    
    struct SectionHeader: View {
        
        let count: Int
        
        let title: String
        
        var body: some View {
            HStack {
                Badge { Text("\(count)") }.padding(.trailing, 6)
                Text(title).font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
        
    }
    
    struct Row: View {
        
        let count: Int
        
        let title: String
        
        let detail: String
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Badge {
                            Text("\(count)")
                        }
                        .backgroundColor(.blue)
                        Text(title)
                    }
                    Text(detail)
                        .font(Font.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
        }
        
    }
    
    let items: Dictionary<String, [LiteratureOrder]>
    
    var body: some View {
        ForEach(items.map { (title: $0, items: $1) }, id: \.title) { section in
            VStack {
                SectionHeader(count: section.items.count, title: section.title)
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(section.items) { order in
                        Row(count: Int(order.quantity), title: order.item!.title!, detail: order.recipient!)
                            .background(
                                Color.secondary
                                    .opacity(0.2)
                                    .cornerRadius(15)
                            )
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
}

struct OrdersListRequestDateView: View {
    
    struct Row: View {
        
        let count: Int
        
        let title: String
        
        let subtitle: String
        
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .firstTextBaseline, spacing: 12) {
                        Badge {
                            Text("\(count)")
                        }
                        .backgroundColor(.blue)
                        Text(title)
                    }
                    Text(subtitle)
                        .font(.headline)
                }
                Spacer()
            }
            .padding()
        }
        
    }
    
    let items: Dictionary<String, [LiteratureOrder]>
    
    var body: some View {
        ForEach(items.map { (title: $0, items: $1) }, id: \.title) { section in
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title)
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(section.items) { order in
                        Row(count: Int(order.quantity), title: order.item!.title!, subtitle: order.recipient!)
                            .background(
                                Color.secondary
                                    .opacity(0.2)
                                    .cornerRadius(15)
                            )
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
}
