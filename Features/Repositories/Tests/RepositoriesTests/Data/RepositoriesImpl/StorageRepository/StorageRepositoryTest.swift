//
//  StorageDataSourceTest.swift
//  Repositories
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
@testable import Repositories

class StorageRepositoryTest: XCTestCase {
    
    private var sut: StorageRepositoryImpl!
    private var dataSource: MockStorageDataSourceImpl!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        dataSource = MockStorageDataSourceImpl()
        sut = StorageRepositoryImpl(dataSource: dataSource)
    }
    
    override func tearDownWithError() throws {
        dataSource = nil
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testSaveCallsStorageRepository() {
        // Act
        sut.saveString("", forKey: "")
        
        // Assert
        XCTAssertTrue(dataSource.saveStringCalled)
    }
    
    func testGetReturnsCorrectValue() {
        // Act
        _ = sut.getString(forKey: "")
        
        // Assert
        XCTAssertTrue(dataSource.getStringCalled)
    }
    
    func testDeletePhotoRemovesValue() {
        // Act
        sut.removeString(forKey: "")
        
        // Assert
        XCTAssertTrue(dataSource.removeStringCalled)
    }
    
}
