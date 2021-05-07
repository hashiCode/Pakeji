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
    
    var body: some View {
        NavigationView {
            self.contentView()
                .navigationTitle("packages.navigationView.title".localized())
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.viewModel.operation = .adding
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
                .sheet(isPresented: Binding<Bool>(get: { self.viewModel.operation == .adding }, set: { _ in }), onDismiss: {
                    self.viewModel.operation = .none
                }) {
                    NewPackageView(viewModel: self.viewModel)
                }
            
        }
        .toolbar {
            ToolbarItem(placement: .status) {
                Text(String(format: "packages.toolbar.totalPackages".localized(), self.viewModel.packages.count))
            }
        }
        
    }
    
    private func contentView() -> AnyView {
        if self.viewModel.packages.count == 0 {
            return AnyView(PackagesEmptyStateView())
        }
//        TODO implement view to show packages
        return AnyView(Text("packages count: \(self.viewModel.packages.count)"))
    }
}
