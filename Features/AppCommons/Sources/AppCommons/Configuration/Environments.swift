//
//  Environments.swift
//
//
//  Created by Yulian Hincapie on 17/04/25.
//

import Foundation

public enum Environments {
    
    static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dictionary
    }()
    
    static let global: [String: Any] = {
        guard let global = Environments.infoDictionary["GlobalVariables"] as? [String : Any] else {
            fatalError("API Key not set in plist for this environment")
        }
        return global
    }()
    
    // Initial Variables
    
    public static let baseUrl: String = {
        guard let baseUrl = Environments.global["BASE_URL"] as? String else {
            fatalError("It not set in plist for this environment")
        }
        return baseUrl
    }()
    
}
