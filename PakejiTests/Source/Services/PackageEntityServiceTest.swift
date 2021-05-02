//
//  PackageEntityServiceTest.swift
//  PakejiTests
//
//  Created by Scott Takahashi on 02/05/21.
//

import XCTest
import CoreData
import Combine

@testable import Pakeji

class PackageEntityServiceTest: XCTestCase {
    
    var sut: PackageEntityService!
    var anyCancelable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        sut = PackageEntityServiceImpl()
    }

    override func tearDownWithError() throws {
        self.cleanDB()
    }

    func testSavePackage() throws {
        let expectation = XCTestExpectation(description: "Save package correctly")
        let packageToBeSaved = Package(id: nil, name: "test", notes: "some test")
        sut.savedPackageSubject.sink { (_) in
            
        } receiveValue: { (package) in
            XCTAssertNotNil(package.id)
                        XCTAssertEqual(package.name, packageToBeSaved.name)
                        XCTAssertEqual(package.notes, packageToBeSaved.notes)
                        expectation.fulfill()
        }.store(in: &anyCancelable)
        self.sut.save(package: packageToBeSaved)
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFindAllPackage() throws {
        let expectation = XCTestExpectation(description: "Find packages correctly")
        
        let context = PersistenceController.shared.container.viewContext
        let package = PackageEntity(context: context)
        package.id = UUID.init()
        package.name = "name"
        package.notes = "notes"
        
        do {
            try context.save()
        } catch {
            XCTFail("problem on test setup")
        }
        
        sut.findPackagesSubject.sink { (_) in
            
        } receiveValue: { (packages) in
            XCTAssertEqual(1, packages.count)
            let packageResult = packages[0]
            XCTAssertEqual(package.id, packageResult.id)
            XCTAssertEqual(package.name, packageResult.name)
            XCTAssertEqual(package.notes, packageResult.notes)
            expectation.fulfill()
        }.store(in: &anyCancelable)
        
        self.sut.findPackages(predicate: nil)
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFindPackageGivenPredicate() throws {
        let expectation = XCTestExpectation(description: "Find packages correctly")
        
        let context = PersistenceController.shared.container.viewContext
        let package = PackageEntity(context: context)
        package.id = UUID.init()
        package.name = "name"
        package.notes = "notes"
        
        let otherPackage = PackageEntity(context: context)
        otherPackage.id = UUID.init()
        otherPackage.name = "other"
        otherPackage.notes = "other notes"
        
        do {
            try context.save()
        } catch {
            XCTFail("problem on test setup")
        }
        
        sut.findPackagesSubject.sink { (_) in
            
        } receiveValue: { (packages) in
            XCTAssertEqual(1, packages.count)
            let packageResult = packages[0]
            XCTAssertEqual(package.id, packageResult.id)
            XCTAssertEqual(package.name, packageResult.name)
            XCTAssertEqual(package.notes, packageResult.notes)
            expectation.fulfill()
        }.store(in: &anyCancelable)
        
        self.sut.findPackages(predicate: NSPredicate(format: "name == %@", String(package.name)))
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    
}

//MARK: helper functions
extension PackageEntityServiceTest {
    private func cleanDB(){
        let context = PersistenceController.shared.container.viewContext
        let request = PackageEntity.fetchRequest()
        do {
            let result = try context.fetch(request)
            for package in result {
                context.delete(package as! NSManagedObject)
                try context.save()
            }
        } catch  {
           fatalError("Unable to clean db test")
        }
    }
}
