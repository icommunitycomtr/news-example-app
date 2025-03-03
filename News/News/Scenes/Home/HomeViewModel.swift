//
//  HomeViewModel.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import Foundation
import Kingfisher

// MARK: - HomeViewModelInputProtocol

protocol HomeViewModelInputProtocol {
    func searchNews(searchString: String, isLoadMore: Bool)
    func fetchTopNews(isLoadMore: Bool)
}

// MARK: - HomeViewModel

final class HomeViewModel {

    // MARK: Properties

    private let newsService: NewsServiceProtocol
    weak var output: HomeViewModelOutputProtocol?

    private var isLoading = false
    private var currentTopNewsPage = 2
    private var currentSearchPage = 1

    private var loadCountSinceLastClear = 0
    private var lastPageImageURLs: [String] = []

    private var searchWorkItem: DispatchWorkItem?

    var news: [Article]
    var filteredNews: [Article]
    var isSearching = false

    // MARK: Init

    init(newsService: NewsServiceProtocol, news: [Article] = []) {
        self.newsService = newsService
        self.news = news
        self.filteredNews = news
    }
}

// MARK: - HomeViewModelInputProtocol

extension HomeViewModel: HomeViewModelInputProtocol {
    func searchNews(searchString: String, isLoadMore: Bool = false) {
        searchWorkItem?.cancel()

        if searchString.isEmpty {
            isSearching = false
            filteredNews = news
            DispatchQueue.main.async {
                self.output?.didFetchNews(success: true)
            }
            return
        }

        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            guard !self.isLoading else { return }
            self.isLoading = true

            if !isLoadMore {
                self.currentSearchPage = 1
            }
            self.isSearching = true

            self.newsService.searchNews(
                searchString: searchString,
                page: self.currentSearchPage,
                pageSize: 20
            ) { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let response):
                    self.handleSearchSuccess(isLoadMore: isLoadMore, articles: response.articles)

                case .failure:
                    DispatchQueue.main.async {
                        self.output?.didFetchNews(success: false)
                    }
                }
            }
        }

        searchWorkItem = workItem
        let delay: TimeInterval = isLoadMore ? 0 : 0.5
        DispatchQueue.global().asyncAfter(deadline: .now() + delay, execute: workItem)
    }

    func fetchTopNews(isLoadMore: Bool = false) {
        guard !isLoading else { return }
        isLoading = true

        if !isLoadMore {
            currentTopNewsPage = 2
        }

        newsService.fetchTopNews(country: "us", pageSize: 20, page: currentTopNewsPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let response):
                self.handleTopNewsSuccess(isLoadMore: isLoadMore, articles: response.articles)

            case .failure:
                DispatchQueue.main.async {
                    self.output?.didFetchNews(success: false)
                }
            }
        }
    }
}

// MARK: - Private Helpers

private extension HomeViewModel {
    func removeImages(urls: [String]) {
        urls.forEach {
            KingfisherManager.shared.cache.removeImage(
                forKey: $0,
                fromMemory: true,
                fromDisk: false
            )
        }
    }

    func handleSearchSuccess(isLoadMore: Bool, articles: [Article]) {
        if isLoadMore {
            removeImages(urls: lastPageImageURLs)
            lastPageImageURLs.removeAll()
        }

        let newPageImageURLs = articles.compactMap { $0.urlToImage }
        lastPageImageURLs.append(contentsOf: newPageImageURLs)

        if isLoadMore {
            filteredNews.append(contentsOf: articles)
        } else {
            filteredNews = articles
        }

        if !articles.isEmpty {
            print("Search page: \(currentSearchPage)")
            currentSearchPage += 1
        }

        DispatchQueue.main.async {
            self.output?.didFetchNews(success: true)
        }
    }

    func handleTopNewsSuccess(isLoadMore: Bool, articles: [Article]) {
        if isLoadMore {
            removeImages(urls: lastPageImageURLs)
            lastPageImageURLs.removeAll()

            loadCountSinceLastClear += 1
            if loadCountSinceLastClear >= 3 {
                removeImages(urls: lastPageImageURLs)
                lastPageImageURLs.removeAll()
                loadCountSinceLastClear = 0
            }
        }

        let newPageImageURLs = articles.compactMap { $0.urlToImage }
        lastPageImageURLs.append(contentsOf: newPageImageURLs)

        if isLoadMore {
            news.append(contentsOf: articles)
            filteredNews.append(contentsOf: articles)
        } else {
            news = articles
            filteredNews = articles
        }

        if !articles.isEmpty {
            print("Top news page: \(currentTopNewsPage)")
            currentTopNewsPage += 1
        }

        DispatchQueue.main.async {
            self.output?.didFetchNews(success: true)
        }
    }
}
