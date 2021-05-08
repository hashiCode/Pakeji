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
                        Button(action: self.showAddView, label: {
                            Image(systemName: "plus")
                        })
                    }
                    ToolbarItem(placement: .status) {
                        Text(String(format: "packages.toolbar.totalPackages".localized(), self.viewModel.packages.count))
                    }
                }
        }
        .sheet(isPresented: Binding<Bool>(get: { self.viewModel.operation == .adding }, set: { _ in }), onDismiss: {
            self.viewModel.operation = .none
        }) {
            NewPackageView(viewModel: self.viewModel)
        }
    }
    
    private func contentView() -> AnyView {
        if self.viewModel.packages.count == 0 {
            return AnyView(PackagesEmptyStateView())
        }
        return AnyView(PackagesListView(viewModel: self.viewModel))
    }
}

extension PackagesView {
    
    func showAddView(){
        self.viewModel.operation = .adding
    }
}
