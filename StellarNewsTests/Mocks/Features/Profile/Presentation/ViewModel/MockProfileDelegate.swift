//
//  MockHomeDelegate.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import StellarNews
@testable import AppCommons

class MockProfileDelegate: ProfileDelegate {
    var cameraStateEvaluated: Bool = false
    var lastCameraState: CameraState?
    
    func evalueCameraState(state: CameraState) {
        cameraStateEvaluated = true
        lastCameraState = state
    }
}
