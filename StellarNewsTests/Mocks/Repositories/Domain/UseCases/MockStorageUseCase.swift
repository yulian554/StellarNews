//
//  MockStorageUseCase.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import StellarNews
@testable import Repositories

class MockStorageUseCase: StorageUseCase {
    var mockString: String = ""
    var saveStringCalled = false
    var getStringCalled = false
    var removeStringCalled = false
    
    func saveString(_ string: String, forKey key: String) {
        saveStringCalled = true
        mockString = string
    }
    
    func getString(forKey key: String) -> String? {
        getStringCalled = true
        return mockString
    }
    
    func removeString(forKey key: String) {
        removeStringCalled = true
    }
}
