//
//  ProfileViewController.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit
import AppCommons

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    lazy var viewModel: ProfileViewModel = ProfileViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setUpView() {
        loadImage()
    }
    
    private func loadImage() {
        userImage.layer.cornerRadius = userImage.frame.height/2
        guard let image = viewModel.getPhoto(), let imageData = Data(base64Encoded: image) else { return }
        userImage.image = UIImage(data: imageData)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        viewModel.openCamera()
    }
    
    @IBAction func deletePhoto(_ sender: Any) {
        viewModel.deletePhoto()
        userImage.image = UIImage(systemName: "person.fill")
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupCaptureSession() {
        Task {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
        }
    }
}

extension ProfileViewController: ProfileDelegate {
    func evalueCameraState(state: CameraState) {
        switch state {
        case .setManual:
            showAlertMessage(
                context: self,
                title: "Permisos de Cámara",
                message: "Debes activar los permisos manualmente para poder acceder a la funcionalidad.",
                textOkButton: "Aceptar"
            ) {
                openSettings()
            }
        case .success:
            self.setupCaptureSession()
        case .denegate:
            return
        }
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        let image = info[.editedImage] as? UIImage
        guard let image else {
            showErrorOfLoadImage()
            return
        }
        
        userImage.image = image
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }
        let base64String = imageData.base64EncodedString()
        
        viewModel.savePhoto(image: base64String)
    }
    
    private func showErrorOfLoadImage() {
        showAlertMessage(
            context: self,
            title: "Algo salió mal",
            message: "No pudimos cargar tu imagen, intentalo nuevamente.",
            textOkButton: "Ok"
        )
    }
}

extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
