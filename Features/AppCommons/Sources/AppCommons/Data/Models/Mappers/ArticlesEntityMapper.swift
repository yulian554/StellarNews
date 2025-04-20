//
//  ArticlesEntityMapper.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation

public class ArticlesEntityMapper: BaseMapper<ArticlesResponse, [ArticlesEntity]> {
    
    override public init() {}

    override public func to(data: ArticlesResponse) -> [ArticlesEntity] {
        return data.results.map { result in
            ArticlesEntity(
                id: result.id,
                title: result.title,
                newsSite: result.newsSite,
                imageUrl: result.imageUrl
            )
        }
    }
    
}
