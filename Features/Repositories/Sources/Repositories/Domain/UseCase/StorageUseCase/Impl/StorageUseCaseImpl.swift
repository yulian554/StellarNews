//
//  StorageUseCaseImpl.swift
//  Repositories
//
//  Created by Yulian Hincapie on 19/04/25.
//

public class StorageUseCaseImpl: StorageUseCase {
    
    private let repository: StorageRepository
    
    public init(repository: StorageRepository = StorageRepositoryImpl()) {
        self.repository = repository
    }
    
    public func saveString(_ string: String, forKey key: String) {
        repository.saveString(string, forKey: key)
    }
    
    public func getString(forKey key: String) -> String? {
        return repository.getString(forKey: key)
    }
    
    public func removeString(forKey key: String) {
        repository.removeString(forKey: key)
    }
    
    
}
