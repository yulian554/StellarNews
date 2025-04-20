//
//  GetProductsByCategorUseCase.swift
//
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
@testable import Repositories

class StorageUseCaseImplTest: XCTestCase {
    
    private var sut: StorageUseCaseImpl!
    private var repository: MockStorageRepositoryImpl!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = MockStorageRepositoryImpl()
        sut = StorageUseCaseImpl(repository: repository)
    }
    
    override func tearDownWithError() throws {
        repository = nil
        sut = nil
        
        try super.tearDownWithError()
    }
    
    func testSaveCallsStorageRepository() {
        // Act
        sut.saveString("", forKey: "")
        
        // Assert
        XCTAssertTrue(repository.saveStringCalled)
    }
    
    func testGetReturnsCorrectValue() {
        // Act
        _ = sut.getString(forKey: "")
        
        // Assert
        XCTAssertTrue(repository.getStringCalled)
    }
    
    func testDeletePhotoRemovesValue() {
        // Act
        sut.removeString(forKey: "")
        
        // Assert
        XCTAssertTrue(repository.removeStringCalled)
    }
    
}
