//
//  LiteratureRequestsView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 11/17/20.
//

import SwiftUI
import CoreData

struct RequestsViewGroupingKey: EnvironmentKey {
    static var defaultValue: LiteratureRequestsView.Grouping = .requestDate
}

extension EnvironmentValues {
    var grouping: LiteratureRequestsView.Grouping {
        get { self[RequestsViewGroupingKey.self] }
        set { self[RequestsViewGroupingKey.self] = newValue }
    }
}

struct LiteratureRequestsView: View {
    
    @EnvironmentObject private var modalManager: ModalManager
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureRequest.date, ascending: true)], animation: .default)
    private var requests: FetchedResults<LiteratureRequest>
    
    
    private let navigationTitle: LocalizedStringKey = "Requests_View_Navigation_Title"
    
    @State private var grouping = LiteratureRequestsView.Grouping.requestDate
    
    
    var body: some View {
        Group {
            if requests.isEmpty {
                ListDefaultView(descriptionKey: "Requests_View_Default_Description") {
                    modalManager.isShowingNewOrderSheet = true
                } image: {
                    Image(systemName: "paperplane.fill")
                        .offset(x: -2, y: 2)
                }
                .foregroundColor(.secondary)
            } else {
                LiteratureRequestsList()
                    .environment(\.grouping, grouping)
            }
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ViewMenu(grouping: $grouping)
        }
    }
    
}

extension LiteratureRequestsView {
    
    enum Grouping: CaseIterable {
        case requestDate, recipient, item
        
        var title: String {
            switch self {
            case .requestDate:
                return "Recently Added"
            case .recipient:
                return "Recipients"
            case .item:
                return "Items"
            }
        }
    }
    
}
