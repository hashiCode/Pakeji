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
    
    var sut: PackagesViewModel!
    var packageEntityService: PackageEntityServiceMock!

    override func setUpWithError() throws {
        packageEntityService = PackageEntityServiceMock()
        sut = PackagesViewModel(packageEntityService: packageEntityService)
        
    }

    func testViewModelInitCorrectly() throws {
        let expectation = XCTestExpectation(description: "View model init correctly")
        packageEntityService.packagesToFind = [Package(id: UUID.init(), name: "pack", notes: "")]
        sut = PackagesViewModel(packageEntityService: packageEntityService)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { expectation.fulfill() }
        wait(for: [expectation], timeout: 1)
        let findPackagesIsCalled = packageEntityService.findPackagesIsCalled
        XCTAssertTrue(findPackagesIsCalled.0)
        XCTAssertNil(findPackagesIsCalled.1)
        
        XCTAssertEqual(PackagesViewModelOperation.none, self.sut.operation)
        XCTAssertEqual(self.packageEntityService.packagesToFind.count, sut.packages.count)
        XCTAssertEqual(self.packageEntityService.packagesToFind.count, sut.packages.count)
    }
    
    func testFindPackagesWithError() {
        let expectation = XCTestExpectation(description: "View model find package correctly")
        self.packageEntityService.findWithError = true
        self.sut.findAllPackages()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(0, self.sut.packages.count)
        XCTAssertEqual(PackagesViewModelOperation.error, self.sut.operation)
    }
    
    func testSavePackageCorrectly() {
        let expectation = XCTestExpectation(description: "View model save package correctly")
        let name = "package"
        let notes = "some note"
        self.sut.savePackage(name: name, notes: notes)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(1, self.sut.packages.count)
        let result = self.sut.packages[0]
        XCTAssertEqual(name, result.name)
        XCTAssertEqual(notes, result.notes)
        XCTAssertEqual(PackagesViewModelOperation.none, self.sut.operation)
    }
    
    func testSavePackageWithError() {
        self.packageEntityService.saveWithError = true
        let expectation = XCTestExpectation(description: "View model save package with error")
        let name = "package"
        let notes = "some note"
        self.sut.savePackage(name: name, notes: notes)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(0, self.sut.packages.count)
        XCTAssertEqual(PackagesViewModelOperation.error, self.sut.operation)
    }
    
    func testDeletePackage() {
        let package = Package(id: UUID.init(), name: "pack", notes: "")
        self.sut.add(package)
        self.packageEntityService.packageToBeDeleted = package
        let expectation = XCTestExpectation(description: "View model delete package correctly")
        self.sut.deletePackage(indexSet: IndexSet(integersIn: 0...0))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { expectation.fulfill() }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(0, self.sut.packages.count)
        XCTAssertEqual(PackagesViewModelOperation.none, self.sut.operation)
    }

}

extension PackagesViewModel {
    
    func add(_ package: Package) {
        self.packages.append(package)
    }
}
