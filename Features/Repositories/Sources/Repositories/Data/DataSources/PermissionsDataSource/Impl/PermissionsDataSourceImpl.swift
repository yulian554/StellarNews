//
//  PermissionsDataSourceImpl.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AVFoundation

public class PermissionsDataSourceImpl: PermissionsDataSource {
    
    public init() {}
    
    public func permissionsOfCamera(completion: @escaping (AVAuthorizationStatus) -> Void) {
        let hasPermissions = AVCaptureDevice.authorizationStatus(for: .video)
        completion(hasPermissions)
    }
    
    
}
