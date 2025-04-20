//
//  ArticleDetailUIModel.swift
//  AppCommons
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Foundation

public struct ArticleDetailUIModel: Codable {
    public let id: Int64?
    public let title: String?
    public let authors: [AuthorsUIModel]?
    public let url: String?
    public let imageUrl: String?
    public let newsSite: String?
    public let summary: String?
    public let publishedAt: String?
    public let updatedAt: String?
    
    init(
        id: Int64?,
        title: String?,
        authors: [AuthorsUIModel]?,
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
}

public struct AuthorsUIModel: Codable {
    public let name: String?
}
