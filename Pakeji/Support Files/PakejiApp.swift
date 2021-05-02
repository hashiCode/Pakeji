//
//  PakejiApp.swift
//  Pakeji
//
//  Created by Scott Takahashi on 25/04/21.
//

import SwiftUI

@main
struct PakejiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PackagesView(packagesViewModel: PackagesViewModel(packageEntityService: PackageEntityServiceImpl()))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
