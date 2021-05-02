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
        sut.savedPackage.sink { (_) in
            
        } receiveValue: { (package) in
            XCTAssertNotNil(package.id)
                        XCTAssertEqual(package.name, packageToBeSaved.name)
                        XCTAssertEqual(package.notes, packageToBeSaved.notes)
                        expectation.fulfill()
        }.store(in: &anyCancelable)
        self.sut.save(package: packageToBeSaved)
        
        wait(for: [expectation], timeout: 3.0)
    }
    
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
