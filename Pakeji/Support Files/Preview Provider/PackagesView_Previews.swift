//
//  PackagesView_Previews.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 04/05/21.
//

import SwiftUI

#if DEBUG
struct PackagesView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesView(packagesViewModel: PackagesViewModelPreview())
    }
}

class PackagesViewModelPreview: PackagesViewModelProtocol {
    
    var packages: [Package] = []
    
    var operation : PackagesViewModelOperation = .none
    
    func findAllPackages() {
        
    }
    
    func savePackage(name: String, notes: String) {
        
    }
    
    func deletePackage(indexSet: IndexSet) {
        
    }
}
#endif
