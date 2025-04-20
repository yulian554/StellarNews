//
//  SearchArticlesUseCase.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import Repositories
import AppCommons

protocol SearchArticlesUseCase: AnyObject {
    func invoke(query: String?) async throws -> [ArticlesEntity]
}
