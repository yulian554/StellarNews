//
//  ArticlesUIMapper.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import Foundation

public class ArticlesUIMapper: BaseMapper<ArticlesEntity, ArticlesUIModel> {
    
    override public init() {}

    override public func to(data: ArticlesEntity) -> ArticlesUIModel {
        ArticlesUIModel(
            id: data.id,
            title: data.title,
            newsSite: data.newsSite,
            imageUrl: data.imageUrl
        )
    }
    
}
