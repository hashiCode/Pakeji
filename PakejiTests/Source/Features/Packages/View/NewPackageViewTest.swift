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
        sut = NewPackageView(viewModel: viewModel, show: .constant(true))
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
    }
    
    func testHaveExpectedWhenNameIsInput() throws {
        sut = NewPackageView(viewModel: viewModel, show: .constant(true), name: "Pack")
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
    }

}
