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
    
    private(set) var savedPackageSubject: PassthroughSubject<Package?, Never> = PassthroughSubject()
    private(set) var findPackagesSubject: PassthroughSubject<[Package]?, Never> = PassthroughSubject()
    private(set) var deletedPackageSubject: PassthroughSubject<Package?, Never> = PassthroughSubject()
    
    var packagesToFind: [Package] = []
    private(set)var findPackagesIsCalled: (Bool, NSPredicate?) = (false, nil)
    
    var saveWithError = false
    var findWithError = false
    
    func save(package: Package) {
        if !saveWithError {
            self.savedPackageSubject.send(Package(id: UUID.init(), name: package.name, notes: package.notes))
        } else {
            self.savedPackageSubject.send(nil)
        }
        
    }
    
    func findPackages(predicate: NSPredicate?) {
        if !findWithError {
            self.findPackagesIsCalled = (true, predicate)
            self.findPackagesSubject.send(packagesToFind)
        }
        else {
            self.findPackagesSubject.send(nil)
        }
        
    }
    
    func delete(id: UUID) {
        
    }
    
}
