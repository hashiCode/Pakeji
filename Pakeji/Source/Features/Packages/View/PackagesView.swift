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
    
    @State
    private var showAddSheet: Bool = false
    
    init(packagesViewModel: PackagesViewModelProtocol) {
        guard let packagesViewModel = packagesViewModel as? PackagesViewModel else { fatalError("should be instance of PackagesViewModelProtocol") }
        self.viewModel = packagesViewModel
        // Changing TextEditor background to none
        UITextView.appearance().backgroundColor = .clear
    }
    
    func contentView() -> AnyView {
        if self.viewModel.packages.count == 0 {
            return AnyView(PackagesEmptyStateView())
        }
//        TODO implement view to show packages
        return AnyView(Text("packages count: \(self.viewModel.packages.count)"))
    }
    
    var body: some View {
        NavigationView {
            self.contentView()
                .navigationTitle("packages.navigationView.title".localized())
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showAddSheet = true
                        }, label: {
                            Image(systemName: "plus")
                        }).sheet(isPresented: self.$showAddSheet) {
                            NewPackageView(viewModel: self.viewModel, show: self.$showAddSheet)
                        }
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
