//
//  DetailViewModel.swift
//  News
//
//  Created by Mert Ozseven on 22.02.2025.
//

import Foundation

protocol DetailViewModelInputProtocol {
}

final class DetailViewModel {

    // MARK: Properties

    var article: Article

    // MARK: Inits

    init(article: Article) {
        self.article = article
    }
}

private extension DetailViewModel {
}

extension DetailViewModel: DetailViewModelInputProtocol {
}
