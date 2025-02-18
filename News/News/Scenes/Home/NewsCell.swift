//
//  NewsCell.swift
//  News
//
//  Created by Mert Ozseven on 17.02.2025.
//

import SnapKit
import UIKit

final class NewsCell: UITableViewCell {

    // MARK: Properties

    static let identifier = "NewsCell"

    private var imageUrl: String?

    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Title"
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "Author"
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemBlue
        return label
    }()

    private let categorySeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.layer.cornerRadius = 4
        return view
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.text = "24m ago"
        return label
    }()

    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "ellipsis")?
                .resized(to: CGSize(width: 24, height: 7))?
                .withTintColor(.label),
            for: .normal
        )
        button.tintColor = .label
        return button
    }()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension NewsCell {
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author

        dateLabel.text = article.publishedAt
        imageUrl = article.urlToImage
    }
}

// MARK: - Private Methods

private extension NewsCell {
    func configureView() {
        addViews()
        configureLayout()
    }

    func addViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(moreButton)
    }

    func configureLayout() {
        newsImageView.snp.makeConstraints {
            $0.top.leading.equalTo(contentView.layoutMarginsGuide)
            $0.width.height.equalTo(136)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.layoutMarginsGuide)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(12)
            $0.trailing.equalTo(contentView.layoutMarginsGuide)
        }
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(12)
            $0.trailing.equalTo(contentView.layoutMarginsGuide)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(newsImageView.snp.trailing).offset(12)
            $0.bottom.equalTo(contentView.layoutMarginsGuide)
            $0.height.equalTo(24)
        }
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalTo(contentView.layoutMarginsGuide)
            $0.width.equalTo(24)
        }
    }
}
