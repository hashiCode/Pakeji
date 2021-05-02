//
//  PackagesViewModelTest.swift
//  PakejiTests
//
//  Created by Scott Takahashi on 02/05/21.
//

import XCTest
import Combine

@testable import Pakeji

class PackagesViewModelTest: XCTestCase {
    
    var sut: PackagesViewModelProtocol!
    var packageEntityService: PackageEntityServiceMock!

    override func setUpWithError() throws {
        packageEntityService = PackageEntityServiceMock()
        sut = PackagesViewModel(packageEntityService: packageEntityService)
        
    }

    func testViewModelInitCorrectly() throws {
        let findPackagesIsCalled = packageEntityService.findPackagesIsCalled
        XCTAssertTrue(findPackagesIsCalled.0)
        XCTAssertNil(findPackagesIsCalled.1)
    }

}
