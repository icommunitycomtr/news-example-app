//
//  HomeViewModel.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import Foundation

// MARK: - HomeViewModelInputProtocol

protocol HomeViewModelInputProtocol {
    func fetchNews()
}

// MARK: - HomeViewModel

final class HomeViewModel {

    // MARK: Properties
    private let newsService: NewsServiceProtocol
    weak var output: HomeViewModelOutputProtocol?
    var news: [Article]

    // MARK: Init
    init(newsService: NewsServiceProtocol, news: [Article] = []) {
        self.newsService = newsService
        self.news = news
    }
}

// MARK: - Private Methods

private extension HomeViewModel {
    func handleNewsResponse(result: Result<NewsModel, NetworkError>) {
        switch result {
        case .success(let response):
            self.news = response.articles
            output?.didFetchNews(success: true)

        case .failure:
            output?.didFetchNews(success: false)
        }
    }
}

// MARK: - HomeViewModelInputProtocol

extension HomeViewModel: HomeViewModelInputProtocol {
    func fetchNews() {
        newsService.fetchNews(searchString: "Technology", page: 1, pageSize: 20) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleNewsResponse(result: result)
            }
        }
    }
}
