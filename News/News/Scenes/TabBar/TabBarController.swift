//
//  TabBarController.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import SnapKit
import UIKit

final class TabBarController: UITabBarController {

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }
}

// MARK: - Private Methods

private extension TabBarController {
    func setupTabs() {
        let homeVC = createNav(
            with: "News",
            and: UIImage(systemName: "newspaper.fill"),
            viewController: HomeViewController(viewModel: HomeViewModel(newsService: NewsService()))
        )
        let settingsVC = createNav(
            with: "Settings",
            and: UIImage(systemName: "gear"),
            viewController: SettingsViewController(viewModel: SettingsViewModel())
        )
        self.setViewControllers([homeVC, settingsVC], animated: false)
    }

    func createNav(
        with title: String,
        and image: UIImage?,
        viewController: UIViewController
    ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        viewController.title = title
        nav.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.largeTitleDisplayMode = .always

        return nav
    }
}
