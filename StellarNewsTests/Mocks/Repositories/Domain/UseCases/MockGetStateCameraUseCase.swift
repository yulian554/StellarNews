//
//  MockGetStateCameraUseCase.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

import AVFoundation
@testable import StellarNews
@testable import AppCommons
@testable import Repositories

class MockGetStateCameraUseCase: GetStateCameraUseCase {
    
    var completionToExecute: ((CameraState) -> Void)?
    var invokeCalled = false
    var stateToReturn: CameraState = .success
    
    public func invoke(completion: @escaping (CameraState) -> Void) {
        invokeCalled = true
        completionToExecute = completion
    }
    
    func executeCompletion() {
        completionToExecute?(stateToReturn)
    }
}
