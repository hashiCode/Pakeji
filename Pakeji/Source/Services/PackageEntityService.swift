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
}

protocol PackageEntityService {
    
    var savedPackage: PassthroughSubject<PackageEntity, PackageEntityServiceError> { get }
    
    
    /// Save a package
    /// - Parameter package: package to be saved
    /// It will pusblish the result on savedPackage subject
    func save(package: Package)
}

class PackageEntityServiceImpl: PackageEntityService {
    
    
    var savedPackage: PassthroughSubject<PackageEntity, PackageEntityServiceError> = PassthroughSubject()
    
    
    func save(package: Package) {
        let persistenceController = PersistenceController.shared
        let context = persistenceController.container.newBackgroundContext()
        let entity = PackageEntity(context: context)
        entity.id = UUID.init()
        entity.name = package.name
        entity.notes = package.notes
        
        context.perform {
            do {
                try context.save()
                self.savedPackage.send(entity)
            } catch {
                self.savedPackage.send(completion: .failure(PackageEntityServiceError.saveError))
            }
        }
        
    }
}
