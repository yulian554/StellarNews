//
//  StorageRepositoryImpl.swift
//  Repositories
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Foundation

public final class StorageRepositoryImpl: StorageRepository {
    
    private let dataSource: StorageDataSource
    
    public init(dataSource: StorageDataSource = StorageDataSourceImpl()) {
        self.dataSource = dataSource
    }
    
    public func saveString(_ string: String, forKey key: String) {
        dataSource.saveString(string, forKey: key)
    }
    
    public func getString(forKey key: String) -> String? {
        return dataSource.getString(forKey: key)
    }
    
    public func removeString(forKey key: String) {
        dataSource.removeString(forKey: key)
    }
    
    
}
