//
//  PackagesViewModelProtocol.swift
//  Pakeji
//
//  Created by Scott Takahashi on 02/05/21.
//

import Foundation
import Combine

protocol PackagesViewModelProtocol {
    
    var packages: [Package] { get }
    
    func findAllPackages()
    
    func savePackage(name: String, notes: String)
    
}

class PackagesViewModel: PackagesViewModelProtocol, ObservableObject{
    
    @Published var packages: [Package] = []
    
    private let packageEntityService: PackageEntityService
    private var anyCancelable = Set<AnyCancellable>()
    
    init(packageEntityService: PackageEntityService) {
        self.packageEntityService = packageEntityService
        self.setupSubscriber()
        self.findAllPackages()
    }
    
    func findAllPackages() {
        self.packageEntityService.findPackages(predicate: nil)
    }
    
    func savePackage(name: String, notes: String) {
        self.packageEntityService.save(package: Package(name: name, notes: notes))
    }
    
}

extension PackagesViewModel {
    private func setupSubscriber() {
        self.packageEntityService.findPackagesSubject
            .receive(on: DispatchQueue.main)
            .sink { (_) in
            } receiveValue: { [weak self] (result) in
                guard let self = self else { return }
                self.packages = result.map { Package(id: $0.id, name: $0.name, notes: $0.notes) }
            }
            .store(in: &anyCancelable)
        
        self.packageEntityService.savedPackageSubject
            .receive(on: DispatchQueue.main)
            .sink { (_) in
            } receiveValue: { [weak self] (result) in
                guard let self = self else { return }
                self.packages.append(Package(id: result.id, name: result.name, notes: result.notes))
            }.store(in: &anyCancelable)
    }
}
