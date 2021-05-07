//
//  PackagesListView.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 07/05/21.
//

import SwiftUI

struct PackagesListView: View {
    
    @ObservedObject var viewModel: PackagesViewModel
    
    init(viewModel: PackagesViewModelProtocol) {
        guard let viewModel = viewModel as? PackagesViewModel else { fatalError() }
        self.viewModel = viewModel
    }
    
    var body: some View {
        List{
            ForEach(self.viewModel.packages) { package in
                PackageListItemView(package: package)
            }
        }
        .listStyle(InsetGroupedListStyle())
        
    }
}
