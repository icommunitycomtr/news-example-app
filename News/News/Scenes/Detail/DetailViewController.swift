//
//  DetailViewController.swift
//  News
//
//  Created by Mert Ozseven on 22.02.2025.
//

import UIKit

protocol DetailViewModelOutputProtocol: AnyObject {
}

final class DetailViewController: UIViewController {

    // MARK: Properties

    // MARK: Inits

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
}

// MARK: - Private Methods

private extension DetailViewController {

    func configureView() {
        addViews()
        configureLayout()
    }

    func addViews() {
    }

    func configureLayout() {
    }
}
