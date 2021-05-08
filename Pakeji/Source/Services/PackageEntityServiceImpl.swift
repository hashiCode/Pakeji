//
//  PackageEntityServiceImpl.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 07/05/21.
//

import Foundation
import CoreData
import Combine

class PackageEntityServiceImpl: PackageEntityService {
    
    
    private(set) var savedPackageSubject: PassthroughSubject<Package?, Never> = PassthroughSubject()
    private(set) var findPackagesSubject: PassthroughSubject<[Package]?, Never> = PassthroughSubject()
    private(set) var deletedPackageSubject: PassthroughSubject<Package?, Never> = PassthroughSubject()
    
    
    func save(package: Package) {
        PersistenceController.shared.container.performBackgroundTask({ (backgroundContext) in
            let entity = PackageEntity(context: backgroundContext)
            entity.id = UUID.init()
            entity.name = package.name
            entity.notes = package.notes
            do {
                try backgroundContext.save()
                self.savedPackageSubject.send(entity.convertToModel())
            } catch {
                self.savedPackageSubject.send(nil)
            }
        })
    }
    
    func findPackages(predicate: NSPredicate?) {
        guard let request = PackageEntity.fetchRequest() as?  NSFetchRequest<PackageEntity> else { fatalError("expected to be a kind of NSFetchRequest<PackageEntity>") }
        request.predicate = predicate
        
        PersistenceController.shared.container.performBackgroundTask({ (backgroundContext) in
            do {
                let result = try backgroundContext.fetch(request)
                self.findPackagesSubject.send(result.map({$0.convertToModel()}))
            } catch {
                self.findPackagesSubject.send(nil)
            }
            
        })
    }
    
    func delete(id: UUID) {
        guard let request = PackageEntity.fetchRequest() as?  NSFetchRequest<PackageEntity> else { fatalError("expected to be a kind of NSFetchRequest<PackageEntity>") }
        request.predicate = NSPredicate(format: "id == %@", "\(id)")
        
        PersistenceController.shared.container.performBackgroundTask({ (backgroundContext) in
            do {
                let result = try backgroundContext.fetch(request)
                if !result.isEmpty {
                    let packageToBeDeleted = result[0].convertToModel()
                    backgroundContext.delete(result[0])
                    try backgroundContext.save()
                    self.deletedPackageSubject.send(packageToBeDeleted)
                } else {
                    self.deletedPackageSubject.send(nil)
                }
            } catch {
                self.deletedPackageSubject.send(nil)
            }
        })
    }
}
