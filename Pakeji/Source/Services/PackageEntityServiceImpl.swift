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
    
    
    private(set) var savedPackageSubject: PassthroughSubject<PackageEntity?, Never> = PassthroughSubject()
    private(set) var findPackagesSubject: PassthroughSubject<[PackageEntity]?, Never> = PassthroughSubject()
    
    
    func save(package: Package) {
        let context = self.getContext()
        let entity = PackageEntity(context: context)
        entity.id = UUID.init()
        entity.name = package.name
        entity.notes = package.notes
        
        context.perform {
            do {
                try context.save()
                self.savedPackageSubject.send(entity)
            } catch {
                self.savedPackageSubject.send(nil)
            }
        }
    }
    
    func findPackages(predicate: NSPredicate?) {
        let context = self.getContext()
        guard let request = PackageEntity.fetchRequest() as?  NSFetchRequest<PackageEntity> else { fatalError("expected to be a kind of NSFetchRequest<PackageEntity>") }
        request.predicate = predicate
        
        context.perform {
            do {
                let result = try context.fetch(request)
                self.findPackagesSubject.send(result)
            } catch {
                self.findPackagesSubject.send(nil)
            }
            
        }
        
    }
}

extension PackageEntityServiceImpl {
    
    private func getContext() -> NSManagedObjectContext {
        let persistenceController = PersistenceController.shared
        let context = persistenceController.container.viewContext
        return context
    }
}
