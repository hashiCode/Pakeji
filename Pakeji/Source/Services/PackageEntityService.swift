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
    
    var savedPackageSubject: PassthroughSubject<PackageEntity?, Never> { get }
    var findPackagesSubject: PassthroughSubject<[PackageEntity]?, Never> { get }
    
    /// Save a package
    /// - Parameter package: package to be saved
    /// It will pusblish the result on savedPackageSubject subject
    func save(package: Package)
    
    /// Find packages given an optional predicate
    /// - Parameter predicate: an optional predicate
    /// It will pusblish the result on findPackagesSubject subject
    func findPackages(predicate: NSPredicate?)
}

