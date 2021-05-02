//
//  PackageEntity.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 27/04/21.
//

import Foundation
import CoreData

@objc(PackageEntity)
final class PackageEntity: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var notes: String
    
}
