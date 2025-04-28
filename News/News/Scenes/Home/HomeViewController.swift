//
//  HomeViewController.swift
//  News
//
//  Created by Mert Ozseven on 4.02.2025.
//

import Kingfisher
import SnapKit
import UIKit

// MARK: - HomeViewModelOutputProtocol

protocol HomeViewModelOutputProtocol: AnyObject {
    func didUpdateArticles(_ articles: [Article], append: Bool)
    func didFail(with error: Error)
    func didBecomeEmpty(_ isEmpty: Bool)
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
        tableView.estimatedRowHeight = 200
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
        self.viewModel.outputDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        viewModel.inputDelegate?.viewDidLoad()
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
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else {
            fatalError()
        }
        cell.configure(with: viewModel.articles[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.compactMap { viewModel.articles[$0.row].urlToImage }.compactMap(URL.init(string:))
        ImagePrefetcher(urls: urls).start()
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController(viewModel: DetailViewModel(article: viewModel.articles[indexPath.row]))
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.articles.count - 1 { viewModel.loadMore() }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? NewsCell)?.cancelImageDownload()
    }
}

// MARK: - HomeViewModelOutputProtocol

extension HomeViewController: HomeViewModelOutputProtocol {
    func didUpdateArticles(_ articles: [Article], append: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
            emptyStateLabel.isHidden = !articles.isEmpty
        }
    }

    func didFail(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let alert = UIAlertController(
                title: "Error",
                message: "Please check your internet connection.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    func didBecomeEmpty(_ isEmpty: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            emptyStateLabel.isHidden = !isEmpty
        }
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
        if text.isEmpty { viewModel.search(term: "") } else
        if text.count >= 3 { viewModel.search(term: text) }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search(term: "")
    }
}
