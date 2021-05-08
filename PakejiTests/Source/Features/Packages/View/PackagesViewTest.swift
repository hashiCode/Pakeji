//
//  PackagesViewTest.swift
//  PakejiTests
//
//  Created by Scott Takahashi on 02/05/21.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
import SwiftUI

@testable import Pakeji

class PackagesViewTest: XCTestCase {
    
    var sut: PackagesView!
    var viewModel: PackagesViewModel!
    var service: PackageEntityServiceMock!

    override func setUpWithError() throws {
        service = PackageEntityServiceMock()
    }

    func testEmptyView() {
        viewModel = PackagesViewModel(packageEntityService: service)
        sut = PackagesView(packagesViewModel: viewModel)
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
        
    }
    
    func testViewWithPackages() {
        self.viewModel = PackagesViewModel(packageEntityService: self.service)
        self.viewModel.packages = [Package(id: UUID.init(), name: "pack1", notes: "")]
        self.sut = PackagesView(packagesViewModel: self.viewModel)
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testShowAddUpdateViewModelCorrectly() {
        viewModel = PackagesViewModel(packageEntityService: service)
        sut = PackagesView(packagesViewModel: viewModel)
        sut.showAddView()
        XCTAssertEqual(PackagesViewModelOperation.adding, viewModel.operation)
    }

}
