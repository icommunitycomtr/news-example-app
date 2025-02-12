//
//  NewsModel.swift
//  News
//
//  Created by Mert Ozseven on 11.02.2025.
//

import Foundation

struct NewsModel: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}

struct Source: Codable {
    let name: String
}
