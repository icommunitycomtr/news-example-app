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

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search News"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        return searchController
    }()

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

    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No news found."
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.isHidden = true
        return label
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
        fetchNewsIfNeeded()
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
        navigationItem.searchController = searchController
        addViews()
        configureLayout()
    }

    func addViews() {
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
    }

    func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        emptyStateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func fetchNewsIfNeeded() {
        if viewModel.filteredNews.isEmpty {
            viewModel.fetchTopNews()
        }
    }

    func updateEmptyStateVisibility() {
        emptyStateLabel.isHidden = !viewModel.filteredNews.isEmpty
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsCell.identifier,
            for: indexPath
        ) as? NewsCell else {
            fatalError("Failed to dequeue cell")
        }

        let article = viewModel.filteredNews[indexPath.row]
        cell.configure(
            with: article.title ?? "",
            author: article.author ?? "",
            date: article.publishedAt ?? "",
            imageUrl: article.urlToImage ?? "",
            url: article.url ?? ""
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController(viewModel: DetailViewModel(article: viewModel.filteredNews[indexPath.row]))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - HomeViewModelOutputProtocol
extension HomeViewController: HomeViewModelOutputProtocol {
    func didFetchNews(success: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateEmptyStateVisibility()
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchNews(searchString: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchNews(searchString: "")
    }
}
