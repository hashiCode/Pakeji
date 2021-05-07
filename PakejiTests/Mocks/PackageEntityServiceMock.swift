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
    
    private(set) var savedPackageSubject: PassthroughSubject<PackageEntity?, Never> = PassthroughSubject()
    private(set) var findPackagesSubject: PassthroughSubject<[PackageEntity]?, Never> = PassthroughSubject()
    
    var packagesToFind: [Package] = []
    private(set)var findPackagesIsCalled: (Bool, NSPredicate?) = (false, nil)
    
    var saveWithError = false
    var findWithError = false
    
    func save(package: Package) {
        if !saveWithError {
            let entity = PackageEntity(context: PersistenceController.shared.container.viewContext)
            entity.id = UUID.init()
            entity.name = package.name
            entity.notes = package.notes
            
            self.savedPackageSubject.send(entity)
        } else {
            self.savedPackageSubject.send(nil)
        }
        
    }
    
    func findPackages(predicate: NSPredicate?) {
        if !findWithError {
            self.findPackagesIsCalled = (true, predicate)
            self.findPackagesSubject.send(packagesToFind.map({
                let entity = PackageEntity(context: PersistenceController.shared.container.viewContext)
                entity.id = $0.id ?? UUID.init()
                entity.name = $0.name
                entity.notes = $0.notes
                return entity
            }))
        }
        else {
            self.findPackagesSubject.send(nil)
        }
        
    }
    
}
