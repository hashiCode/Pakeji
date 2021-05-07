//
//  PackageListItemView_Previews.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 07/05/21.
//

import SwiftUI

struct PackageListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PackageListItemView(package: Package(id: nil, name: "pack", notes: ""))
    }
}
