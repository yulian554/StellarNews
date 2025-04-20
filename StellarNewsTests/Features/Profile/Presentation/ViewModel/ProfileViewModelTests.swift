//
//  ProfileViewModelTests.swift
//  StellarNewsTests
//
//  Created by Yulian Hincapie on 20/04/25.
//

import XCTest
@testable import StellarNews
@testable import AppCommons
@testable import Repositories

class ProfileViewModelTests: XCTestCase {
    
    private var mockDelegate: MockProfileDelegate?
    
    func buildSut(
        mockCameraUseCase: MockGetStateCameraUseCase = MockGetStateCameraUseCase(),
        mockStorageUseCase: MockStorageUseCase = MockStorageUseCase()
    ) -> ProfileViewModel {
        mockDelegate = MockProfileDelegate()
        
        return ProfileViewModel(
            delegate: mockDelegate,
            storageUseCase: mockStorageUseCase,
            getStateCameraUseCase: mockCameraUseCase
        )
    }
    
    // MARK: - Tests
    func testOpenCameraCallsDelegate() {
        // Arrange
        let mockCameraUseCase = MockGetStateCameraUseCase()
        let sut = buildSut(mockCameraUseCase: mockCameraUseCase)
        
        // Act
        sut.openCamera()
        
        mockCameraUseCase.executeCompletion()
        
        // Assert
        XCTAssertTrue(mockDelegate?.cameraStateEvaluated ?? false)
        XCTAssertEqual(mockDelegate?.lastCameraState, .success)
    }
    
    func testSavePhotoCallsStorageUseCase() {
        // Arrange
        let mockStorageUseCase = MockStorageUseCase()
        let sut = buildSut(mockStorageUseCase: mockStorageUseCase)
        
        // Act
        sut.savePhoto(image: "")
        
        // Assert
        XCTAssertTrue(mockStorageUseCase.saveStringCalled)
    }
    
    func testGetPhotoReturnsCorrectValue() {
        // Arrange
        let mockStorageUseCase = MockStorageUseCase()
        let sut = buildSut(mockStorageUseCase: mockStorageUseCase)
        let image = "Mock image"
        
        // Act
        sut.savePhoto(image: image)
        let result = sut.getPhoto()
        
        // Assert
        XCTAssertTrue(mockStorageUseCase.getStringCalled)
        XCTAssertEqual(result, image)
    }
    
    func testDeletePhotoRemovesValue() {
        // Arrange
        let mockStorageUseCase = MockStorageUseCase()
        let sut = buildSut(mockStorageUseCase: mockStorageUseCase)
        
        // Act
        sut.deletePhoto()
        
        // Assert
        XCTAssertTrue(mockStorageUseCase.removeStringCalled)
    }
}
