//
//  PackageListItemView.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 07/05/21.
//

import SwiftUI

struct PackageListItemView: View {
    
    let package: Package
    
    var body: some View {
        Text(package.name)
    }
}

