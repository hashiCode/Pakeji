//
//  PackagesView.swift
//  Pakeji
//
//  Created by Scott Takahashi on 25/04/21.
//

import SwiftUI

struct PackagesView: View {
    var body: some View {
        NavigationView {
                Text("Packeges View")
            .navigationTitle(LocalizedStringKey("packages.navigationView.title"))
            .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

struct PackagesView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesView()
    }
}
