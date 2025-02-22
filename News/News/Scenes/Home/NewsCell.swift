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
        imageView.image = UIImage(systemName: "newspaper")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
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
        label.numberOfLines = 0
        return label
    }()

    private let hourLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemBlue
        return label
    }()

    private let hourSeperatorView: UIView = {
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

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension NewsCell {
    func configure(with title: String, author: String, date: String, imageUrl: String) {
        titleLabel.text = title
        authorLabel.text = author
        hourLabel.text = date.formattedHourAndMinute() ?? "Unknown time"
        dateLabel.text = date.timeAgoSinceDate() ?? "Unknown time"
        self.imageUrl = imageUrl
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
        contentView.addSubview(hourLabel)
        contentView.addSubview(hourSeperatorView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(separatorView)
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(12)
            $0.trailing.equalTo(contentView.layoutMarginsGuide)
        }
        hourLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(12)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(12)
            $0.height.equalTo(24)
        }
        hourSeperatorView.snp.makeConstraints {
            $0.leading.equalTo(hourLabel.snp.trailing).offset(12)
            $0.centerY.equalTo(hourLabel)
            $0.width.equalTo(8)
            $0.height.equalTo(8)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(hourSeperatorView.snp.trailing).offset(12)
            $0.centerY.equalTo(hourLabel)
            $0.height.equalTo(24)
        }
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalTo(contentView.layoutMarginsGuide)
            $0.width.equalTo(24)
        }
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView.layoutMarginsGuide)
            $0.top.equalTo(dateLabel.snp.bottom).offset(32)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}

#Preview {
    HomeViewController(viewModel: HomeViewModel(newsService: NewsService()))
}
