//
//  ThemeSelectorCell.swift
//  News
//
//  Created by Mert Ozseven on 26.02.2025.
//

import UIKit

final class ThemeSelectorCell: UITableViewCell {

    // MARK: Properties

    static let identifier = "ModeSelectorCell"

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

extension ThemeSelectorCell {

}

// MARK: - Private Methods

private extension ThemeSelectorCell {
    func configureView() {
        addViews()
        configureLayout()
    }

    func addViews() {
        
    }

    func configureLayout() {

    }
}
