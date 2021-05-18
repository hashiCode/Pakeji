//
//  PackagesViewModel.swift
//  Pakeji
//
//  Created by Scott Yamagami Takahashi on 07/05/21.
//

import Foundation
import Combine

class PackagesViewModel: PackagesViewModelProtocol, ObservableObject{
    
    @Published var packages: [Package] = []
    
    @Published var operation: PackagesViewModelOperation = .none {
        didSet {
            print("novo valor de op: \(operation)")
        }
    }
    
    private let packageEntityService: PackageEntityService
    private var anyCancelable = Set<AnyCancellable>()
    
    init(packageEntityService: PackageEntityService) {
        self.packageEntityService = packageEntityService
        self.setupSubscriber()
        self.findAllPackages()
    }
    
    func findAllPackages() {
        self.operation = .fetching
        self.packageEntityService.findPackages(predicate: nil)
    }
    
    func savePackage(name: String, notes: String) {
        self.operation = .adding
        self.packageEntityService.save(package: Package(name: name, notes: notes))
    }
    
    func deletePackage(indexSet: IndexSet) {
        indexSet.forEach { (index) in
            let package = self.packages[index]
            if let id = package.id {
                self.packageEntityService.delete(id: id)
            }
        }
    }
}

extension PackagesViewModel {
    private func setupSubscriber() {
        self.packageEntityService.findPackagesSubject
            .receive(on: DispatchQueue.main)
            .sink {(result) in
                if let result = result {
                    self.operation = .none
                    self.packages = result
                } else {
                    self.operation = .error
                }
            }
            .store(in: &anyCancelable)
        
        self.packageEntityService.savedPackageSubject
            .receive(on: DispatchQueue.main)
            .sink {(result) in
                if let result = result {
                    self.operation = .none
                    self.packages.append(result)
                } else {
                    self.operation = .error
                }
            }
            .store(in: &anyCancelable)
        
        self.packageEntityService.deletedPackageSubject
            .receive(on: DispatchQueue.main)
            .sink {(result) in
                if let result = result {
                    self.operation = .none
                    if let index = self.packages.firstIndex(where: { (package) -> Bool in
                        result.id == package.id
                    }) {
                        self.packages.remove(at: index)
                    }
                } else {
                    self.operation = .error
                }
            }
            .store(in: &anyCancelable)
    }
}
