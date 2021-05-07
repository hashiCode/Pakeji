//
//  NewPackageView_Previews.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 04/05/21.
//

import SwiftUI

struct NewPackageView_Previews: PreviewProvider {
    static var previews: some View {
        NewPackageView(viewModel: PackagesViewModel(packageEntityService: PackageEntityServiceImpl()))
    }
}
