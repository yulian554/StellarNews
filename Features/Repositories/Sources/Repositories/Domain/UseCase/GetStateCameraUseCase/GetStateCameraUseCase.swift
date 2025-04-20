//
//  GetStateCameraUseCase.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AppCommons
import AVFoundation

public protocol GetStateCameraUseCase {
    func invoke(completion: @escaping (CameraState) -> Void)
}
