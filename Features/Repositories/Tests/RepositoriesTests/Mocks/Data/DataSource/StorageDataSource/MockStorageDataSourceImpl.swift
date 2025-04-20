//
//  MockStorageDataSourceImpl.swift
//  Repositories
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import Repositories
@testable import AppCommons
import Foundation

final class MockStorageDataSourceImpl: StorageDataSource {
    var saveStringCalled = false
    var getStringCalled = false
    var removeStringCalled = false
    
    func saveString(_ string: String, forKey key: String) {
        saveStringCalled = true
    }
    
    func getString(forKey key: String) -> String? {
        getStringCalled = true
        return ""
    }
    
    func removeString(forKey key: String) {
        removeStringCalled = true
    }
    
}
