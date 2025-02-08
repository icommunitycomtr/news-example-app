//
//  SettingsViewController.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import UIKit

protocol SettingsViewModelOutputProtocol {
}

final class SettingsViewController: UIViewController {

    // MARK: Properties
    private let viewModel: SettingsViewModel

    // MARK: Inits
    init(viewModel: SettingsViewModel) {
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
    }
}

// MARK: - Private Methods
private extension SettingsViewController {

    func configureView() {
        view.backgroundColor = .primaryBackground
        addViews()
        configureLayout()
    }

    func addViews() {
    }

    func configureLayout() {
    }
}

// MARK: - SettingsViewModelOutputProtocol
extension SettingsViewController: SettingsViewModelOutputProtocol {
}
