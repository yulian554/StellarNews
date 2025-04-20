//
//  ArticlesEntity.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation

public struct ArticlesEntity {
    
    public let id: Int64?
    public let title: String?
    public let newsSite: String?
    public let imageUrl: String?
    
    init(id: Int64?, title: String?, newsSite: String?, imageUrl: String?) {
        self.id = id
        self.title = title
        self.newsSite = newsSite
        self.imageUrl = imageUrl
    }

}
