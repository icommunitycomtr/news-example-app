//
//  SplashViewController.swift
//  News
//
//  Created by Mert Ozseven on 6.02.2025.
//

import SnapKit
import UIKit

protocol SplashOutputProtocol: AnyObject {
    func transitionToMainScene()
}

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
        label.textColor = .label
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private var viewModel: SplashViewModel

    // MARK: Inits

    init(viewModel: SplashViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        viewModel.outputDelegate = self
        viewModel.inputDelegate?.splashScreenLoaded()
    }
}

// MARK: - Private Methods

private extension SplashViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
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
}

// MARK: - SplashOutputProtocol

extension SplashViewController: SplashOutputProtocol {
    func transitionToMainScene() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        let tabBarController = TabBarController()

        UIView.transition(
            with: sceneDelegate.window!,
            duration: 0.7,
            options: .transitionFlipFromRight,
            animations: {
                sceneDelegate.window?.rootViewController = tabBarController
            })
    }
}
