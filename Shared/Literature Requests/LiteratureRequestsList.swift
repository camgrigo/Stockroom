//
//  LiteratureRequestsList.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/25/20.
//

import SwiftUI
import CoreData

extension LiteratureRequest: Identifiable {}

extension LiteratureRequestItem: Identifiable {}

class RequestDataSource: ObservableObject {
    
    private lazy var requests = {
        let context = PersistenceController.shared.container.viewContext
        let fetchedResultsController = context.fetch(LiteratureRequest.fetchRequest())
    }()
    
    @Published var searchText = String()
    
    var sections: [(title: String, items: [LiteratureRequest])] {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        
        return Dictionary(grouping: requests) { $0.date! }
            .map {
                (
                    title: formatter.string(from: $0.key),
                    items: $0.value
                )
            }
    }
    
}

struct LiteratureRequestsList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiteratureRequest.date, ascending: true)], animation: .default)
    private var requests: FetchedResults<LiteratureRequest>
    
    @ObservedObject private var dataSource = RequestDataSource(
    
    
    var body: some View {
        List {
            SearchBar(text: $dataSource.searchText)
            
            ForEach(dataSource.sections, id: \.title) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) {
                        row(request: $0)
                    }
                }
            }
            
            OverscrollSpacer()
        }
    }
    
    private var dateFormatter: DateFormatter {
        DateFormatter()
    }
    
    private func row(request: LiteratureRequest) -> some View {
        VStack {
            Text("\(request.date!, formatter: dateFormatter)")
            Text("\(request.isRecurring ? "Standing Request" : "")")
            Text(request.recipient ?? String())
            ForEach(request.itemsArray) { requestItem in
                HStack {
                    Text(requestItem.literatureItem.title!)
                    Text("\(requestItem.quantity)").bold()
                }
            }
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
