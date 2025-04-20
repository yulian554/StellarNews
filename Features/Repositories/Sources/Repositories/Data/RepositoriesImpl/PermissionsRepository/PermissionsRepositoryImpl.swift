//
//  PermissionsRepositoryImpl.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AVFoundation

public class PermissionsRepositoryImpl: PermissionsRepository {
    
    private let dataSource: PermissionsDataSource
    
    public init(dataSource: PermissionsDataSource = PermissionsDataSourceImpl()) {
        self.dataSource = dataSource
    }
    
    public func permissionsOfCamera(completion: @escaping (AVAuthorizationStatus) -> Void) {
        dataSource.permissionsOfCamera(completion: completion)
    }
    
    
}
