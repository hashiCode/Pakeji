//
//  PackageEntityService.swift
//  Pakeji
//
//  Created by Scott Takahashi on 02/05/21.
//

import Foundation
import CoreData
import Combine

enum PackageEntityServiceError: Error {
    case saveError
    case fetchError
}

protocol PackageEntityService {
    
    var savedPackageSubject: PassthroughSubject<Package?, Never> { get }
    var findPackagesSubject: PassthroughSubject<[Package]?, Never> { get }
    var deletedPackageSubject: PassthroughSubject<Package?, Never> { get }
    
    /// Save a package
    /// - Parameter package: package to be saved
    /// It will pusblish the result on savedPackageSubject subject
    func save(package: Package)
    
    /// Find packages given an optional predicate
    /// - Parameter predicate: an optional predicate
    /// It will pusblish the result on findPackagesSubject subject
    func findPackages(predicate: NSPredicate?)
    
    
    /// delete a package given an id
    /// - Parameter id: id of package
    /// It will publish the deleted pack on deletedPackageSubject. It will publish nill if it was not possible to delete
    func delete(id: UUID)
}

