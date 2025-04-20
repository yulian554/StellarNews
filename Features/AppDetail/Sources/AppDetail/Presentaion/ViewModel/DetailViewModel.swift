//
//  DetailViewModel.swift
//  AppDetail
//
//  Created by Yulian Hincapie on 19/04/25.
//

import SwiftUI
import AppCommons

enum DetailState {
    case loadin
    case success(_ data: ArticleDetailUIModel)
    case failure(_ error: DetailsErrors)
}

final class DetailViewModel: BaseViewModel, ObservableObject {
    @Published var state: DetailState
    
    private let getDetailUseCase: GetDetailUseCase
    
    init(
        state: DetailState = .loadin,
        getDetailUseCase: GetDetailUseCase = GetDetailUseCaseImpl()
    ) {
        self.getDetailUseCase = getDetailUseCase
        self.state = state
    }
    
    func loadDetail(id: String) async {
        do {
            let response = try await getDetailUseCase.invoke(id: id)
            let data = ArticleDetailUIMapper().to(data: response)
            state = .success(data)
        } catch let error {
            failureLoadDetail(error: error)
        }
    }
    
    private func failureLoadDetail(error: Error) {
        validateError(
            error: error,
            forNetwork: { [weak self] in
                self?.state = .failure(.errorNetworkDetail)
            },
            forGenericError: { [weak self] in
                self?.state = .failure(.errorLoadDetail)
            }
        )
    }
}
