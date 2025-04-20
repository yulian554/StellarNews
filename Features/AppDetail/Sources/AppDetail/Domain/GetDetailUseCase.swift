//
//  GetDetailUseCase.swift
//  AppDetail
//
//  Created by Yulian Hincapie on 19/04/25.
//

import AppCommons
import Repositories

public protocol GetDetailUseCase: Sendable {
    func invoke(id: String?) async throws -> ArticleDetailEntity
}
