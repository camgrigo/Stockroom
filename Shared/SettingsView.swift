//
//  SettingsView.swift
//  Stockroom
//
//  Created by Cameron Grigoriadis on 12/13/20.
//

import SwiftUI

struct SettingsView: View {
    
    private let navigationTitle: LocalizedStringKey = "Settings_View_Navigation_Title"
    
    var body: some View {
        Text("Settings")
            .navigationTitle(navigationTitle)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
