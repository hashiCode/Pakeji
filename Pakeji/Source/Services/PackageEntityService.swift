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
    
    var savedPackageSubject: PassthroughSubject<PackageEntity, PackageEntityServiceError> { get }
    var findPackagesSubject: PassthroughSubject<[PackageEntity], PackageEntityServiceError> { get }
    
    /// Save a package
    /// - Parameter package: package to be saved
    /// It will pusblish the result on savedPackageSubject subject
    func save(package: Package)
    
    /// Find packages given an optional predicate
    /// - Parameter predicate: an optional predicate
    /// It will pusblish the result on findPackagesSubject subject
    func findPackages(predicate: NSPredicate?)
}

class PackageEntityServiceImpl: PackageEntityService {
    
    
    var savedPackageSubject: PassthroughSubject<PackageEntity, PackageEntityServiceError> = PassthroughSubject()
    var findPackagesSubject: PassthroughSubject<[PackageEntity], PackageEntityServiceError> = PassthroughSubject()
    
    
    func save(package: Package) {
        let context = self.getContext()
        let entity = PackageEntity(context: context)
        entity.id = UUID.init()
        entity.name = package.name
        entity.notes = package.notes
        
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                try context.save()
                self.savedPackageSubject.send(entity)
            } catch {
                self.savedPackageSubject.send(completion: .failure(PackageEntityServiceError.saveError))
            }
        }
    }
    
    func findPackages(predicate: NSPredicate?) {
        let context = self.getContext()
        guard let request = PackageEntity.fetchRequest() as?  NSFetchRequest<PackageEntity> else { fatalError("expected to be a kind of NSFetchRequest<PackageEntity>") }
        request.predicate = predicate
        
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                let result = try context.fetch(request)
                self.findPackagesSubject.send(result)
            } catch {
                self.findPackagesSubject.send(completion: .failure(PackageEntityServiceError.fetchError))
            }
            
        }
        
    }
}

extension PackageEntityServiceImpl {
    
    private func getContext() -> NSManagedObjectContext {
        let persistenceController = PersistenceController.shared
        let context = persistenceController.container.newBackgroundContext()
        return context
    }
}
