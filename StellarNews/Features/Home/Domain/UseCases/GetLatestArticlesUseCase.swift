//
//  GetLatestArticlesUseCase.swift
//
//
//  Created by Yulian Hincapie on 18/04/25.
//

import AppCommons

protocol GetLatestArticlesUseCase {
    func invoke(limit: String?) async throws -> [ArticlesEntity]
}
