//
//  HomeViewController.swift
//  News
//
//  Created by Mert Ozseven on 4.02.2025.
//

import UIKit

protocol HomeViewModelOutputProtocol {

}

final class HomeViewController: UIViewController {

    // MARK: Properties
    private let viewModel: HomeViewModel

    // MARK: Inits
    init(viewModel: HomeViewModel) {
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
private extension HomeViewController {

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

// MARK: - HomeViewModelOutputProtocol
extension HomeViewController: HomeViewModelOutputProtocol {

}
