//
//  ArticleDetailEntityMapper.swift
//
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Foundation

public class ArticleDetailEntityMapper: BaseMapper<ArticleDetailResponse, ArticleDetailEntity> {
    
    override public init() {}

    override public func to(data: ArticleDetailResponse) -> ArticleDetailEntity {
         ArticleDetailEntity(
            id: data.id,
            title: data.title,
            authors: data.authors?.map{ result in AuthorsEntityMapper().to(data: result) },
            url: data.url,
            imageUrl: data.imageUrl,
            newsSite: data.newsSite,
            summary: data.summary,
            publishedAt: data.publishedAt,
            updatedAt: data.updatedAt
        )
    }
    
}

fileprivate class AuthorsEntityMapper: BaseMapper<AuthorsResponse?, AuthorsEntity> {
    override public init() {}
    
    override public func to(data: AuthorsResponse?) -> AuthorsEntity {
        AuthorsEntity(name: data?.name ?? "")
    }
}
