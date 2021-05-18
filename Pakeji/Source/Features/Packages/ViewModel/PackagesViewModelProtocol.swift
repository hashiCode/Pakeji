//
//  PackagesViewModelProtocol.swift
//  Pakeji
//
//  Created by Scott Takahashi on 02/05/21.
//

import Foundation
import Combine

enum PackagesViewModelOperation {
    case none
    case fetching
    case adding
    case error
}

protocol PackagesViewModelProtocol {
    
    var packages: [Package] { get }
    
    var operation: PackagesViewModelOperation { get }
    
    func findAllPackages()
    
    func savePackage(name: String, notes: String)
    
    func deletePackage(indexSet: IndexSet)
    
}
