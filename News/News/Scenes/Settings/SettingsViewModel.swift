//
//  SettingsViewModel.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import Foundation
import UserNotifications

protocol SettingsViewModelInputProtocol: AnyObject {
    func updateTheme(themeMode: Int)
    func fetchSavedTheme() -> Int
    func updateNotificationSettings(isEnabled: Bool)
    func fetchNotificationStatus(completion: @escaping (Bool) -> Void)
    func handleSelection(for item: SettingItem)
}

final class SettingsViewModel {

    // MARK: Properties

    weak var inputDelegate: SettingsViewModelInputProtocol?
    weak var outputDelegate: SettingsViewModelOutputProtocol?

    private let themeKey = "selectedTheme"

    let settingsSections: [SettingsSection] = [
        .appearance([
            SettingItem(title: "App Theme", icon: "circle.righthalf.filled", type: .theme)
        ]),
        .notifications([
            SettingItem(title: "Notification", icon: "bell.fill", type: .notification)
        ]),
        .general([
            SettingItem(title: "Rate Us", icon: "star.fill", type: .defaultItem)
        ]),
        .legal([
            SettingItem(title: "Privacy Policy", icon: "text.document.fill", type: .defaultItem),
            SettingItem(title: "Terms of Use", icon: "checkmark.shield.fill", type: .defaultItem)
        ]),
        .version([])
    ]

    init() {
        inputDelegate = self
    }
}

// MARK: - SettingsViewModelInputProtocol

extension SettingsViewModel: SettingsViewModelInputProtocol {

    func fetchSavedTheme() -> Int {
        UserDefaults.standard.integer(forKey: themeKey)
    }

    func updateTheme(themeMode: Int) {
        UserDefaults.standard.set(themeMode, forKey: themeKey)
        outputDelegate?.didUpdateTheme(themeMode: themeMode)
    }

    func updateNotificationSettings(isEnabled: Bool) {
        if isEnabled {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { [weak self] granted, _ in
                DispatchQueue.main.async {
                    self?.outputDelegate?.didFetchNotificationStatus(isEnabled: granted)
                }
            }
        }
    }

    func fetchNotificationStatus(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }

    func handleSelection(for item: SettingItem) {
        switch item.type {
        case .defaultItem:
            switch item.title {
            case "Rate Us":
                outputDelegate?.promptAppReview()

            case "Privacy Policy":
                outputDelegate?.openExternalLink(url: "https://mertozseven.com")

            case "Terms of Use":
                outputDelegate?.openExternalLink(url: "https://mertozseven.com")

            default:
                break
            }

        default:
            break
        }
    }
}
