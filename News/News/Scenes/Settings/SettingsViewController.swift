//
//  SettingsViewController.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import UIKit
import SafariServices
import SnapKit
import StoreKit

protocol SettingsViewModelOutputProtocol: AnyObject {
    func didUpdateTheme(_ mode: Int)
    func didUpdateNotification(_ isAuthorized: Bool)
    func openURL(_ url: String)
    func promptReview()
}

final class SettingsViewController: UIViewController {

    // MARK: Properties

    private let viewModel: SettingsViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    // MARK: Inits

    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.outputDelegate = self
    }

    required init?(coder: NSCoder) { fatalError() }

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
        addViews()
        configureLayout()
    }

    func addViews() {
        view.addSubview(tableView)
    }

    func configureLayout() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.tintColor = .label

        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]

        cell.textLabel?.text = item.title
        cell.textLabel?.textAlignment = .natural
        cell.textLabel?.textColor = .label
        cell.imageView?.image = UIImage(systemName: item.iconName)

        switch item.type {
        case .theme:
            let segmentedControl = UISegmentedControl(items: ["Auto", "Light", "Dark"])
            segmentedControl.selectedSegmentIndex = viewModel.inputDelegate?.fetchThemeMode() ?? 0
            segmentedControl.addTarget(self, action: #selector(didChangeTheme(_:)), for: .valueChanged)
            cell.accessoryView = segmentedControl

        case .notification:
            let switcher = UISwitch()
            viewModel.inputDelegate?.fetchNotificationStatus { switcher.isOn = $0 }
            switcher.addTarget(self, action: #selector(didToggleNotification), for: .valueChanged)
            cell.accessoryView = switcher

        case .rateApp, .privacyPolicy, .termsOfUse:
            cell.selectionStyle = .default
            cell.accessoryType = .disclosureIndicator

        case .version:
            cell.imageView?.image = nil
            cell.textLabel?.textColor = .secondaryLabel
            cell.textLabel?.textAlignment = .center
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = .clear
        }
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        viewModel.inputDelegate?.didSelect(item: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

@objc private extension SettingsViewController {
    func didChangeTheme(_ sender: UISegmentedControl) {
        viewModel.inputDelegate?.updateThemeMode(sender.selectedSegmentIndex)
    }
    func didToggleNotification(_ sender: UISwitch) {
        viewModel.inputDelegate?.updateNotification(isOn: sender.isOn)
    }
}

extension SettingsViewController: SettingsViewModelOutputProtocol {
    func didUpdateTheme(_ mode: Int) {
        switch mode {
        case 1: view.window?.overrideUserInterfaceStyle = .light
        case 2: view.window?.overrideUserInterfaceStyle = .dark
        default: view.window?.overrideUserInterfaceStyle = .unspecified
        }
    }

    func didUpdateNotification(_ isAuthorized: Bool) {
        print("Notifications \(isAuthorized ? "On" : "Off")")
    }

    func openURL(_ url: String) {
        guard let urlToOpen = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: urlToOpen)
        safariVC.modalPresentationStyle = .overFullScreen
        present(safariVC, animated: true)
    }

    func promptReview() {
        if let scn = view.window?.windowScene {
            SKStoreReviewController.requestReview(in: scn)
        }
    }
}
