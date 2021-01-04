//
//  LiteratureRequestsView+ViewMenu.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/23/20.
//

import SwiftUI

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
