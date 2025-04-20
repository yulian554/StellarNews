//
//  AppErrors.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import UIKit

public func showGenericNettworkError<T: UIViewController>(context: T) {
    showAlertMessage(
        context: context,
        title: "Sin internet",
        message: "Parece que no tienes conexión a internet, por favor revisa la red.",
        textOkButton: "Ok"
    )
}

public func showGenericError<T: UIViewController>(context: T) {
    showAlertMessage(
        context: context,
        title: "Algo salió mal",
        message: "En estos momentos la app no está disponible, por favor intentalo mas tarde.",
        textOkButton: "Ok"
    )
}

