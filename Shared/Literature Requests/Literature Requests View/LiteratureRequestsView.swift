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

typealias LiteratureRequestsViewSection = (title: String, items: [LiteratureRequest])

struct LiteratureRequestsView: View {
    
    @EnvironmentObject private var modalManager: ModalManager
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: LiteratureRequest.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureRequest.date, ascending: true)],
        animation: .default
    )
    private var requests: FetchedResults<LiteratureRequest>
    
    
    private let navigationTitle: LocalizedStringKey = "Requests_View_Navigation_Title"
    
    @State private var grouping = LiteratureRequestsView.Grouping.requestDate
    
    
    @State private var searchText = String()
    
    
//    private var sections: [LiteratureRequestsViewSection] {
//        switch grouping {
//        case .requestDate:
//            return Dictionary(grouping: requests) { $0.date! }
//                .sorted { $0.0 > $1.0 }
//                .map { pair in (title: {
//                    let dateFormatter = DateFormatter()
//
//                    dateFormatter.dateStyle = .medium
//                    dateFormatter.timeStyle = .none
//
//                    return dateFormatter.string(from: pair.0)
//                }(), items: pair.1) }
//
//        case .recipient:
//            return Dictionary(
//
//        case .item:
//
////            return Dictionary(grouping: requests) { request in
////                switch grouping {
////                case .requestDate:
////                    let dateFormatter = DateFormatter()
////
////                    dateFormatter.dateStyle = .medium
////                    dateFormatter.timeStyle = .none
////
////                    return dateFormatter.string(from: request.date!)
////
////                case .recipient:
////                    return request.recipient!
////
////                case .item:
////                    return request.item!.title!
////                }
////            }
////            .sorted { $0.0 < $1.0 }
////            .map { (title: $0.0, items: $0.1) }
//        }
//    }
    
    private var defaultView: some View {
        ListDefaultView(descriptionKey: "Requests_View_Default_Description") {
            modalManager.isShowingNewOrderSheet = true
        } image: {
            Image(systemName: "paperplane.fill")
                .offset(x: -2, y: 2)
        }
        .foregroundColor(.secondary)
    }
    
    var body: some View {
        Group {
            //            if !sections.isEmpty {
            //                List {
            //                    SearchBar(text: $searchText)
            //
            //                    ForEach(sections, id: \.title) { section in
            //                        OrdersListSection(section: section) {
            //                            ForEach(section.items) {
            //                                LiteratureRequestRow(order: $0)
            //                            }
            //                        }
            //                        .environment(\.grouping, grouping)
            //                    }
            //
            //                    OverscrollSpacer()
            //                }
            //
            //            } else {
            defaultView
            //            }
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ViewMenu(grouping: $grouping)
        }
    }
    
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets
    //                .map { items[$0] }
    //                .forEach(viewContext.delete)
    //
    //            PersistenceController.save(viewContext)
    //        }
    //    }
    
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

extension LiteratureRequestsView {
    
    struct ViewMenu: View {
        
        @EnvironmentObject var modalManager: ModalManager
        
        @Binding var grouping: LiteratureRequestsView.Grouping
        
        var body: some View {
            Menu {
                Section {
                    Button {
                        modalManager.isShowingNewOrderSheet = true
                    } label: {
                        Label("New Request", systemImage: "square.and.pencil")
                    }
                }
                
                Section {
                    Picker(selection: $grouping, label: Text("View")) {
                        ForEach(Grouping.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                }
            }
            label: {
                Label("Menu", systemImage: "ellipsis.circle")
                    .imageScale(.large)
            }
        }
        
    }
    
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        LiteratureRequestsView()
    }
}
