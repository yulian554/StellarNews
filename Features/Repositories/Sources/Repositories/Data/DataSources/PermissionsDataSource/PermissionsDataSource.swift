//
//  PermissionsDataSource.swift
//  
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AVFoundation

public protocol PermissionsDataSource: AnyObject {
    func permissionsOfCamera(completion: @escaping (AVAuthorizationStatus) -> Void)
}

