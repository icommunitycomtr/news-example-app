//
//  DetailViewController.swift
//  News
//
//  Created by Mert Ozseven on 22.02.2025.
//

import SnapKit
import UIKit

protocol DetailViewModelOutputProtocol: AnyObject {
}

final class DetailViewController: UIViewController {

    // MARK: Properties

    var viewModel: DetailViewModel

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.article.title
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = .label
        return label
    }()

    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.setImage(with: viewModel.article.urlToImage, placeholder: UIImage(systemName: "photo.artframe"))
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    private lazy var articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.article.content
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = .label
        return label
    }()

    // MARK: Inits

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - Private Methods

private extension DetailViewController {

    func configureView() {
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
    }

    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(articleImageView)
        stackView.addArrangedSubview(articleDescriptionLabel)
    }

    func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(view.layoutMarginsGuide)
        }
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
        articleImageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
}

// MARK: - Objective Methods

private extension DetailViewController {
    @objc func imageTapped() {
        let previewVC = ImagePreviewViewController(imageURL: viewModel.article.urlToImage)
        previewVC.modalPresentationStyle = .fullScreen
        present(previewVC, animated: true)
    }
}
