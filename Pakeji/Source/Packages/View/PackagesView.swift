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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {print("add pack")}, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
            
        }
        .toolbar {
            ToolbarItem(placement: .status) {
                Text("0 packages") //TODO: placeholder. show packages saved on coredata db
            }
        }
        
    }
}

struct PackagesView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesView()
    }
}
