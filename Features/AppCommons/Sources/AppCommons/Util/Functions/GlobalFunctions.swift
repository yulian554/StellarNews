//
//  GlobalFunctions.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import UIKit

public func openSettings() {
    if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

public func formatDate(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    let formats = [
        "yyyy-MM-dd'T'HH:mm:ss'Z'",
        "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'",
    ]
            
    for format in formats {
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy/MM/dd"
            return dateFormatter.string(from: date)
        }
    }
    
    return dateString
}
