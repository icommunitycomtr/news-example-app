//
//  SettingsCell.swift
//  News
//
//  Created by Mert Ozseven on 26.02.2025.
//

import UIKit
import SnapKit

final class SettingsCell: UITableViewCell {

    // MARK: Properties

    static let identifier = "SettingsCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        return label
    }()

    // MARK: Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

extension SettingsCell {
}


// MARK: - Private Methods

private extension SettingsCell {
    func configureView() {
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        addViews()
        configureLayout()
    }

    func addViews() {
        contentView.addSubview(titleLabel)
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.layoutMarginsGuide)
        }
    }
}
