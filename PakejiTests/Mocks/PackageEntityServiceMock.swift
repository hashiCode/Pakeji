//
//  PackageEntityServiceMock.swift
//  PakejiTests
//
//  Created by Scott Takahashi on 02/05/21.
//

import Foundation
import Combine
@testable import Pakeji

class PackageEntityServiceMock: PackageEntityService {
    
    private(set) var savedPackageSubject: PassthroughSubject<PackageEntity, PackageEntityServiceError> = PassthroughSubject()
    private(set) var findPackagesSubject: PassthroughSubject<[PackageEntity], PackageEntityServiceError> = PassthroughSubject()
    
    var packagesToFind: [Package] = []
    private(set)var findPackagesIsCalled: (Bool, NSPredicate?) = (false, nil)
    
    
    func save(package: Package) {
        let entity = PackageEntity(context: PersistenceController.shared.container.viewContext)
        entity.id = UUID.init()
        entity.name = package.name
        entity.notes = package.notes
        
        self.savedPackageSubject.send(entity)
        
    }
    
    func findPackages(predicate: NSPredicate?) {
        self.findPackagesIsCalled = (true, predicate)
        self.findPackagesSubject.send(packagesToFind.map({
            let entity = PackageEntity(context: PersistenceController.shared.container.viewContext)
            entity.id = $0.id ?? UUID.init()
            entity.name = $0.name
            entity.notes = $0.notes
            return entity
        }))
        
    }
    
}
