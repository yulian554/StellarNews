//
//  ArticlesResponse.swift
//  
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation

public struct ArticlesResponse: Codable {
    public let results: [ResultsResponse]
}

public struct ResultsResponse: Codable {
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

    enum CodingKeys: String, CodingKey {
        case title, id
        case newsSite = "news_site"
        case imageUrl = "image_url"
    }
}
