//
//  MockGetDetailUseCase.swift
//  AppDetail
//
//  Created by Yulian Hincapie on 20/04/25.
//

@testable import AppDetail
@testable import AppCommons

class MockGetDetailUseCase: GetDetailUseCase, @unchecked Sendable {
    
    var resultToReturn: ArticleDetailEntity?
    var errorToThrow: Error?
    var invokeWasCalled = false
    var lastIdReceived: String?
    
    func invoke(id: String?) async throws -> ArticleDetailEntity {
        invokeWasCalled = true
        lastIdReceived = id
        
        if let error = errorToThrow {
            throw error
        }
        
        if let result = resultToReturn {
            return result
        }
        
        fatalError("MockGetDetailUseCase should have either resultToReturn or errorToThrow set")
    }
}
