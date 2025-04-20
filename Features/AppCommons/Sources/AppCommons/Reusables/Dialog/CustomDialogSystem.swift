//
//  CustomDialogSystem.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import UIKit

public func showAlertMessage<T: UIViewController>(
    context: T,
    title: String,
    message: String,
    textOkButton: String,
    action: (() -> Void)? = nil
) {
    
    let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let declineButton = UIAlertAction(title: action != nil ? "Cancelar" : textOkButton, style: .default)
    
    if let action {
        let okButton = UIAlertAction(title: textOkButton, style: .default, handler: { _ in action() })
        alertMessagePopUpBox.addAction(okButton)
    }
    alertMessagePopUpBox.addAction(declineButton)
    context.present(alertMessagePopUpBox, animated: true)
}
