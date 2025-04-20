//
//  SearchViewModel.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 19/04/25.
//

import AppCommons

class SearchViewModel: BaseViewModel {
    
    weak var delegate: SearchDelegate?
    private var searchArticlesUseCase: SearchArticlesUseCase
    
    init(
        delegate: SearchDelegate? = nil,
        searchArticlesUseCase: SearchArticlesUseCase = SearchArticlesUseCaseImpl()
    ) {
        self.delegate = delegate
        self.searchArticlesUseCase = searchArticlesUseCase
    }
    
    func searchProducts(_ complement: String) {
        Task { await loadItems(complement) }
    }
    
    private func loadItems(_ complement: String) async {
        do {
            let response = try await searchArticlesUseCase.invoke(query: complement)
            let articles = response.map { result in ArticlesUIMapper().to(data: result) }
            successLoadArticles(articles: articles)
        } catch let error {
            failureLoadArticles(error: error)
        }
    }
    
    private func successLoadArticles(articles: [ArticlesUIModel]) {
        delegate?.didSearchArticles(articles)
    }
    
    private func failureLoadArticles(error: Error) {
        validateError(
            error: error,
            forNetwork: { [weak self] in
                self?.delegate?.didNetworkError()
            },
            forGenericError: { [weak self] in
                self?.delegate?.didErrorSearchArticles()
            },
            forEmptyResponse: { [weak self] in
                self?.delegate?.didSearchArticlesEmpty()
            }
        )
    }

}
