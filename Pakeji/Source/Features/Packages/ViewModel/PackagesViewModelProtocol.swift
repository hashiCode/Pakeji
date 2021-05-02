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
    
}

class PackagesViewModel: PackagesViewModelProtocol, ObservableObject{
    
    @Published private(set) var packages: [Package] = []
    
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
    
}

extension PackagesViewModel {
    private func setupSubscriber() {
        self.packageEntityService.findPackagesSubject.sink { (_) in
        } receiveValue: { [weak self] (result) in
            guard let self = self else { return }
            self.packages = result.map({
                return Package(id: $0.id, name: $0.name, notes: $0.notes)
            })
        }.store(in: &anyCancelable)
    }
}
