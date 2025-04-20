//
//  StorageDataSourceImpl.swift
//  Repositories
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Foundation

public final class StorageDataSourceImpl: StorageDataSource {
    
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    public func saveString(_ string: String, forKey key: String) {
        userDefaults.set(string, forKey: key)
    }
    
    public func getString(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    public func removeString(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    
}
