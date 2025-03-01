//
//  HomeViewController.swift
//  News
//
//  Created by Mert Ozseven on 4.02.2025.
//

import SnapKit
import UIKit

// MARK: - HomeViewModelOutputProtocol

protocol HomeViewModelOutputProtocol: AnyObject {
    func didFetchNews(success: Bool)
}

// MARK: - HomeViewController

final class HomeViewController: UIViewController {

    // MARK: Properties
    private let viewModel: HomeViewModel
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 1
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Private Methods

private extension HomeViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
    }

    func addViews() {
        view.addSubview(tableView)
    }

    func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.news.count)
        return viewModel.news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next line_length
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            fatalError("Failed to dequeue cell")
        }
        cell.configure(
            with: viewModel.news[indexPath.row].title ?? "",
            author: viewModel.news[indexPath.row].author ?? "",
            date: viewModel.news[indexPath.row].publishedAt ?? "",
            imageUrl: viewModel.news[indexPath.row].urlToImage ?? "",
            url: viewModel.news[indexPath.row].url ?? ""
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(
            DetailViewController(viewModel: DetailViewModel(article: viewModel.news[indexPath.row])),
            animated: true
        )
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
