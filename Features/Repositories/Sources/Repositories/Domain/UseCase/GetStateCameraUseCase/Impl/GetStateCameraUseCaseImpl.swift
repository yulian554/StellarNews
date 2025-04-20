//
//  GetStateCameraUseCaseImpl.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AppCommons
import AVFoundation

public class GetStateCameraUseCaseImpl: GetStateCameraUseCase {
    
    private let repository: PermissionsRepository
    
    public init(repository: PermissionsRepository = PermissionsRepositoryImpl()) {
        self.repository = repository
    }
    
    public func invoke(completion: @escaping (CameraState) -> Void) {
        repository.permissionsOfCamera(completion: { state in
            self.getState(state: state, completion: completion)
        })
    }
    
    private func getState(state: AVAuthorizationStatus, completion: @escaping (CameraState) -> Void) {
        switch state {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async(execute: {
                    granted ? completion(.success) : completion(.denegate)
                })
            }
        case .authorized:
            completion(.success)
        case .restricted, .denied:
            completion(.setManual)
        @unknown default:
            completion(.setManual)
        }
    }
    
    
}
