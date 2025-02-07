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
            vc: HomeViewController()
        )
        let settingsVC = createNav(
            with: "Settings",
            and: UIImage(systemName: "gear"),
            vc: SettingsViewController()
        )
        self.setViewControllers([homeVC, settingsVC], animated: false)
    }

    func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        vc.title = title
        nav.navigationBar.prefersLargeTitles = true
        vc.navigationItem.largeTitleDisplayMode = .always

        return nav
    }
}
