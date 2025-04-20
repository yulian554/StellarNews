//
//  PermissionsRepository.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AVFoundation

public protocol PermissionsRepository: AnyObject {
    func permissionsOfCamera(completion: @escaping (AVAuthorizationStatus) -> Void)
}
