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
        viewModel = PackagesViewModel(packageEntityService: service)
        
    }

    func testEmptyView() throws {
        sut = PackagesView(packagesViewModel: viewModel)
        let viewController = UIHostingController(rootView: sut)
        viewController.view.frame = UIScreen.main.bounds
        assertSnapshot(matching: viewController, as: .image)
        
    }

}
