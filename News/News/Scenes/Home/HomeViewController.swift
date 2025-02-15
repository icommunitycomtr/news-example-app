//
//  HomeViewController.swift
//  News
//
//  Created by Mert Ozseven on 4.02.2025.
//

import UIKit

// MARK: - HomeViewModelOutputProtocol

protocol HomeViewModelOutputProtocol: AnyObject {
    func didFetchNews(success: Bool)
}

// MARK: - HomeViewController

final class HomeViewController: UIViewController {

    // MARK: Properties
    private let viewModel: HomeViewModel
    private let tableView = UITableView()

    // MARK: Inits
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.searchNews(searchString: "Apple")
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    func configureView() {
        view.backgroundColor = .white
        setupTableView()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.news[indexPath.row].title
        return cell
    }
}

// MARK: - HomeViewModelOutputProtocol

extension HomeViewController: HomeViewModelOutputProtocol {
    func didFetchNews(success: Bool) {
        if success {
            tableView.reloadData()
        } else {
            print("Failed to fetch news")
        }
    }
}
