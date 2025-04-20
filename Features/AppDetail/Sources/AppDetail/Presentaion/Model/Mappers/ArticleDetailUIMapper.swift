//
//  ArticleDetailUIMapper.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Foundation
import AppCommons

public class ArticleDetailUIMapper: BaseMapper<ArticleDetailEntity, ArticleDetailUIModel> {
    
    override public init() {}

    override public func to(data: ArticleDetailEntity) -> ArticleDetailUIModel {
        ArticleDetailUIModel(
            id: data.id,
            title: data.title,
            authors: data.authors?.map { result in AuthorsUIMapper().to(data: result) },
            url: data.url,
            imageUrl: data.imageUrl,
            newsSite: data.newsSite,
            summary: data.summary,
            publishedAt: data.publishedAt,
            updatedAt: data.updatedAt
        )
    }
}

fileprivate class AuthorsUIMapper: BaseMapper<AuthorsEntity?, AuthorsUIModel> {
    override public init() {}
    
    override public func to(data: AuthorsEntity?) -> AuthorsUIModel {
        AuthorsUIModel(name: data?.name ?? "")
    }
}
