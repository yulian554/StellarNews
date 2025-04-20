//
//  StorageUseCase.swift
//  Repositories
//
//  Created by Yulian Hincapie on 19/04/25.
//

public protocol StorageUseCase {
    func saveString(_ string: String, forKey key: String)
    func getString(forKey key: String) -> String?
    func removeString(forKey key: String)
}
