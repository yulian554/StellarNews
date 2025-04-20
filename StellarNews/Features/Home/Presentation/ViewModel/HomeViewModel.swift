//
//  HomeViewModel.swift
//  StellarNews
//
//  Created by Yulian Hincapie on 17/04/25.
//

import Combine
import AppCommons
import Foundation
import Repositories

class HomeViewModel: BaseViewModel {
    
    weak var delegate: HomeDelegate?
    private let getLatestArticlesUseCase: GetLatestArticlesUseCase
    private let storageUseCase: StorageUseCase
    
    private var subscribers = Set<AnyCancellable>()
    
    init(
        delegate: HomeDelegate? = nil,
        storageUseCase: StorageUseCase = StorageUseCaseImpl(),
        getLatestArticlesUseCase: GetLatestArticlesUseCase = GetLatestArticlesUseCaseImpl()
    ) {
        self.delegate = delegate
        self.storageUseCase = storageUseCase
        self.getLatestArticlesUseCase = getLatestArticlesUseCase
    }
    
    func getRecentArticles() {
        self.setupNetworkMonitor()
        Task { await self.loadArticles() }
    }
    
    private func loadArticles() async {
        do {
            let response = try await getLatestArticlesUseCase.invoke(limit: nil)
            let articles = response.map{ result in ArticlesUIMapper().to(data: result) }
            successLoadArticles(articles: articles)
        } catch let error {
            failureLoadArticles(error: error)
        }
    }
    
    private func successLoadArticles(articles: [ArticlesUIModel]) {
        delegate?.didLoadArticles(articles)
    }
    
    private func failureLoadArticles(error: Error) {
        validateError(
            error: error,
            forNetwork: { [weak self] in
                self?.delegate?.didNetworkError()
            },
            forGenericError: { [weak self] in
                self?.delegate?.didErrorLoadArticles()
            }
        )
    }
    
    func getPhoto() -> String? {
        return storageUseCase.getString(forKey: UserDefaultKeys.userImage.rawValue)
    }
    
    func setupNetworkMonitor() {
        let network = NetworkMonitor.shared
        network.$networkStatus
            .dropFirst()
            .sink{ [weak self] _ in
                guard let self else { return }
                self.delegate?.didNetworkError()
            }
            .store(in: &subscribers)
    }
}
