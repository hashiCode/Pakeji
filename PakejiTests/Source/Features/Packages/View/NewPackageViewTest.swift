//
//  NewPackageViewTest.swift
//  PakejiTests
//
//  Created by Scott Takahashi on 02/05/21.
//

import XCTest
import SnapshotTesting
import ComposableArchitecture
import SwiftUI
@testable import Pakeji

class NewPackageViewTest: XCTestCase {

    var sut: NewPackageView!
    var viewModel: PackagesViewModel!
    var service: PackageEntityServiceMock!

    override func setUpWithError() throws {
        service = PackageEntityServiceMock()
        viewModel = PackagesViewModel(packageEntityService: service)
        
    }

    func testHaveExpectedInitialApperance() throws {
        sut = NewPackageView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testHaveExpectedSnapshotWhenNameIsInput() throws {
        sut = NewPackageView(viewModel: viewModel, name: "Pack")
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
    }
    
    //TODO resolve alert issue and update this test case
    func testHaveExpectedSnapshotWhenAnErrorHappens() throws {
        service.saveWithError = true
        sut = NewPackageView(viewModel: viewModel, name: "Pack")
        sut.save()
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
    }

}
