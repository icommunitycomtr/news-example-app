//
//  HomeViewModel.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import Foundation

// MARK: - HomeViewModelInputProtocol

protocol HomeViewModelInputProtocol {
    func searchNews(searchString: String)
    func fetchTopNews()
}

// MARK: - HomeViewModel

final class HomeViewModel {

    // MARK: Properties
    private let newsService: NewsServiceProtocol
    weak var output: HomeViewModelOutputProtocol?

    var news: [Article]
    var filteredNews: [Article] = []
    var isSearching: Bool = false
    private var searchWorkItem: DispatchWorkItem?

    // MARK: Init
    init(newsService: NewsServiceProtocol, news: [Article] = []) {
        self.newsService = newsService
        self.news = news
        self.filteredNews = news
    }
}

// MARK: - Private Methods

private extension HomeViewModel {
    func handleNewsResponse(result: Result<NewsModel, NetworkError>) {
        switch result {
        case .success(let response):
            self.news = response.articles
            self.filteredNews = response.articles
            DispatchQueue.main.async {
                self.output?.didFetchNews(success: true)
            }

        case .failure:
            DispatchQueue.main.async {
                self.output?.didFetchNews(success: false)
            }
        }
    }
}

// MARK: - HomeViewModelInputProtocol

extension HomeViewModel: HomeViewModelInputProtocol {
    func searchNews(searchString: String) {
        searchWorkItem?.cancel()

        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }

            if searchString.isEmpty {
                self.isSearching = false
                self.filteredNews = self.news
                DispatchQueue.main.async {
                    self.output?.didFetchNews(success: true)
                }
            } else {
                self.isSearching = true
                self.newsService.searchNews(
                    searchString: searchString,
                    page: 1,
                    pageSize: 100
                ) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let response):
                            self.filteredNews = response.articles
                            self.output?.didFetchNews(success: true)
                        case .failure:
                            self.output?.didFetchNews(success: false)
                        }
                    }
                }
            }
        }

        searchWorkItem = workItem
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }

    func fetchTopNews() {
        newsService.fetchTopNews(
            country: "us",
            pageSize: 100,
            page: 1
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleNewsResponse(result: result)
            }
        }
    }
}
