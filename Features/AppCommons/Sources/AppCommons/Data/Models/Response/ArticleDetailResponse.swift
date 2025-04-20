//
//  ArticleDetailResponse.swift
//  AppCommons
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Foundation

public struct ArticleDetailResponse: Codable {
    public let id: Int64?
    public let title: String?
    public let authors: [AuthorsResponse]?
    public let url: String?
    public let imageUrl: String?
    public let newsSite: String?
    public let summary: String?
    public let publishedAt: String?
    public let updatedAt: String?
    
    init(
        id: Int64?,
        title: String?,
        authors: [AuthorsResponse]?,
        url: String?,
        imageUrl: String?,
        newsSite: String?,
        summary: String?,
        publishedAt: String?,
        updatedAt: String?
    ) {
        self.id = id
        self.title = title
        self.authors = authors
        self.url = url
        self.imageUrl = imageUrl
        self.newsSite = newsSite
        self.summary = summary
        self.publishedAt = publishedAt
        self.updatedAt = updatedAt
    }

    enum CodingKeys: String, CodingKey {
        case id, title, authors, url
        case newsSite = "news_site"
        case imageUrl = "image_url"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}

public struct AuthorsResponse: Codable {
    public let name: String?
}
