//
//  NewsCell.swift
//  News
//
//  Created by Mert Ozseven on 17.02.2025.
//

import Kingfisher
import SnapKit
import UIKit

final class NewsCell: UITableViewCell {

    // MARK: Properties

    static let identifier = "NewsCell"
    private var url: String?
    private var article: Article?

    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(systemName: "photo.artframe")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
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
        return label
    }()

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .large)
        button.setPreferredSymbolConfiguration(imageConfig, forImageIn: .normal)
        button.setImage(
            UIImage(systemName: "ellipsis")?
                .withTintColor(.label),
            for: .normal
        )
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .label
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
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
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author
        hourLabel.text = article.publishedAt?.formattedHourAndMinute() ?? "Unknown time"
        dateLabel.text = article.publishedAt?.timeAgoSinceDate() ?? "Unknown time"
        url = article.url
        newsImageView.setImage(with: article.urlToImage)
    }

    func cancelImageDownload() {
        newsImageView.kf.cancelDownloadTask()
    }

    func clearImage() {
        newsImageView.image = nil
    }
}

// MARK: - Objective Methods

private extension NewsCell {
    @objc func didTapMoreButton() {
        guard let url = url, let shareUrl = URL(string: url) else { return }

        let openInBrowserActivity = OpenInBrowserActivity()
        let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            let activityVC = UIActivityViewController(
                activityItems: [shareUrl],
                applicationActivities: [openInBrowserActivity]
            )

            if let topController = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow })?.rootViewController {

                if let popoverController = activityVC.popoverPresentationController {
                    popoverController.sourceView = self.moreButton
                    popoverController.sourceRect = self.moreButton.bounds
                }

                topController.present(activityVC, animated: true)
            }
        }

        let menu = UIMenu(title: "", children: [shareAction])
        moreButton.menu = menu
        moreButton.showsMenuAsPrimaryAction = true
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
            $0.top.equalTo(newsImageView.snp.bottom).offset(24).priority(.low)
            $0.top.greaterThanOrEqualTo(hourLabel.snp.bottom).offset(24).priority(.high)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
    }
}
