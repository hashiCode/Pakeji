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
    
    func testSavePackageCorrectly() {
        let expectation = XCTestExpectation(description: "View model save package correctly")
        let name = "package"
        let notes = "some note"
        self.sut.savePackage(name: name, notes: notes)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(1, self.sut.packages.count)
        let result = self.sut.packages[0]
        XCTAssertEqual(name, result.name)
        XCTAssertEqual(notes, result.notes)
    }

}
