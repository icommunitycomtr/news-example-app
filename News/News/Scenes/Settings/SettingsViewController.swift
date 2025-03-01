//
//  SettingsViewController.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import SafariServices
import StoreKit
import UIKit

final class SettingsViewController: UIViewController {

    // MARK: Properties

    private let viewModel: SettingsViewModel

    private var appVersion: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
        return "Version \(version) (\(build))"
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: Inits

    init(viewModel: SettingsViewModel) {
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
}

// MARK: - Private Methods

private extension SettingsViewController {
    func configureView() {
        view.backgroundColor = .systemGroupedBackground
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true

        addViews()
        configureLayout()
    }

    func addViews() {
        view.addSubview(tableView)
    }

    func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.settingsSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = viewModel.settingsSections[section]
        switch sectionType {
        case .version:
            return 1

        default:
            return sectionType.items.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let sectionType = viewModel.settingsSections[indexPath.section]

        if case .version = sectionType {
            cell.textLabel?.text = appVersion
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .secondaryLabel
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }

        let item = sectionType.items[indexPath.row]

        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.imageView?.tintColor = .label
        cell.accessoryView = nil
        cell.selectionStyle = .none

        switch item.type {
        case .theme:
            let themeControl = UISegmentedControl(items: ["Light", "Dark"])
            themeControl.selectedSegmentIndex = viewModel.fetchSavedTheme() ? 1 : 0
            themeControl.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
            cell.accessoryView = themeControl

        case .notification:
            let switchControl = UISwitch()
            viewModel.fetchNotificationStatus { isAuthorized in
                switchControl.isOn = isAuthorized
            }
            switchControl.addTarget(self, action: #selector(notificationToggled(_:)), for: .valueChanged)
            cell.accessoryView = switchControl

        case .defaultItem:
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.settingsSections[indexPath.section].items[indexPath.row]
        viewModel.handleSelection(for: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc private func themeChanged(_ sender: UISegmentedControl) {
        let isDarkMode = sender.selectedSegmentIndex == 1
        viewModel.updateTheme(isDarkMode: isDarkMode)
    }

    @objc private func notificationToggled(_ sender: UISwitch) {
        viewModel.updateNotificationSettings(isEnabled: sender.isOn)
    }
}

// MARK: - SettingsViewModelOutputProtocol

extension SettingsViewController: SettingsViewModelOutputProtocol {
    func didUpdateTheme(isDarkMode: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.view.window?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }

    func didFetchNotificationStatus(isEnabled: Bool) {
        tableView.reloadData()
    }

    func openExternalLink(url: String) {
        guard let url = URL(string: url) else { return }

        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true)
    }

    func promptAppReview() {
        if let windowScene = view.window?.windowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
