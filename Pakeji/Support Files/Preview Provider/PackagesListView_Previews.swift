//
//  PackagesListView_Previews.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 07/05/21.
//

import SwiftUI

#if DEBUG
struct PackagesListView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesListView(viewModel: PackagesViewModelPreview())
    }
}
#endif
