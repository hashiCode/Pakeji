//
//  PackagesView.swift
//  Pakeji
//
//  Created by Scott Takahashi on 25/04/21.
//

import SwiftUI

struct PackagesView: View {
    
    @ObservedObject
    private var viewModel: PackagesViewModel
    
    init(packagesViewModel: PackagesViewModelProtocol) {
        self.viewModel = packagesViewModel as! PackagesViewModel
    }
    
    var body: some View {
        NavigationView {
            Text("Packeges View")
                .navigationTitle("packages.navigationView.title".localized())
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
                Text(String(format: "packages.toolbar.totalPackages".localized(), self.viewModel.packages.count))
            }
        }
        
    }
}

#if DEBUG
class PackagesViewModelPreview: PackagesViewModelProtocol {
    
    var packages: [Package] = []
    
    func findAllPackages() {
        
    }
}

struct PackagesView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesView(packagesViewModel: PackagesViewModelPreview())
    }
}

#endif
