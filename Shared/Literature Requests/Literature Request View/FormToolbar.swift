//
//  FormToolbar.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/18/20.
//

import SwiftUI

struct FormToolbar: ToolbarContent {
    
    var canSubmit: Bool
    
    
    let cancel: () -> Void
    
    let done: () -> Void
    
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel_Button_Title", action: cancel)
        }
        
        ToolbarItem(placement: .confirmationAction) {
            Button("Done_Button_Title", action: done)
                .disabled(!canSubmit)
        }
    }
    
}
