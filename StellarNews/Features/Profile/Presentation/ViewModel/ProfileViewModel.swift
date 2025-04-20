//
//  ProfileViewModel.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Repositories

class ProfileViewModel {
    
    private let getStateCameraUseCase: GetStateCameraUseCase
    private let storageUseCase: StorageUseCase
    
    weak var delegate: ProfileDelegate?
    
    init(
        delegate: ProfileDelegate? = nil,
        storageUseCase: StorageUseCase = StorageUseCaseImpl(),
        getStateCameraUseCase: GetStateCameraUseCase = GetStateCameraUseCaseImpl()
    ) {
        self.delegate = delegate
        self.storageUseCase = storageUseCase
        self.getStateCameraUseCase = getStateCameraUseCase
    }
    
    func openCamera() {
        getStateCameraUseCase.invoke(completion: { [weak self] state in
            guard let self else { return }
            self.delegate?.evalueCameraState(state: state)
        })
    }
    
    func savePhoto(image: String) {
        storageUseCase.saveString(image, forKey: UserDefaultKeys.userImage.rawValue)
    }
    
    func getPhoto() -> String? {
        return storageUseCase.getString(forKey: UserDefaultKeys.userImage.rawValue)
    }
    
    func deletePhoto() {
        storageUseCase.removeString(forKey: UserDefaultKeys.userImage.rawValue)
    }
}
