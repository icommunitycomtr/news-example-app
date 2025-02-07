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
    }
}

// MARK: - Private Methods
private extension SplashViewController {
    func configureView() {
        view.backgroundColor = .systemRed
        addViews()
        configureLayout()
        navigateToHome()
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

    func navigateToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let homeViewController = HomeViewController()
            let navigationController = UINavigationController(rootViewController: homeViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true)
        }
    }
}
