//
//  SplashViewController.swift
//  News
//
//  Created by Mert Ozseven on 6.02.2025.
//

import SnapKit
import UIKit

final class SplashViewController: UIViewController {

    // MARK: Properties

    private let newsService = NewsService()
    private var fetchedNews: [Article] = []

    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "newspaper.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "Mert News"
        label.textColor = .primaryLabel
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        fetchNews()
        navigateToHome()
    }
}

// MARK: - Private Methods
private extension SplashViewController {
    func configureView() {
        view.backgroundColor = .primaryBackground
        addViews()
        configureLayout()
    }

    func addViews() {
        view.addSubview(newsImageView)
        view.addSubview(newsLabel)
    }

    func configureLayout() {
        newsImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-16)
            $0.width.height.equalTo(224)
        }
        newsLabel.snp.makeConstraints {
            $0.top.equalTo(newsImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
    }

    func fetchNews() {
        newsService.fetchTopNews(country: "us") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.fetchedNews = response.articles
                    self?.navigateToHome()

                case .failure:
                    print("Failed to fetch news")
                    self?.navigateToHome()
                }
            }
        }
    }

    func navigateToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            let tabBarController = TabBarController(news: self.fetchedNews)
            if sceneDelegate.window?.rootViewController is TabBarController {
                return
            }
            UIView.transition(
                with: sceneDelegate.window!,
                duration: 0.5,
                options: .transitionFlipFromRight,
                animations: {
                    sceneDelegate.window?.rootViewController = tabBarController
                })
        }
    }
}
