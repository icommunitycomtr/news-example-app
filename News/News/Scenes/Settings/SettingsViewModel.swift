//
//  SettingsViewModel.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import Foundation
import UserNotifications

protocol SettingsViewModelInputProtocol {
    func updateTheme(isDarkMode: Bool)
    func fetchSavedTheme() -> Bool
    func updateNotificationSettings(isEnabled: Bool)
    func fetchNotificationStatus(completion: @escaping (Bool) -> Void)
    func handleSelection(for item: SettingItem)
}

protocol SettingsViewModelOutputProtocol: AnyObject {
    func didUpdateTheme(isDarkMode: Bool)
    func didFetchNotificationStatus(isEnabled: Bool)
    func openExternalLink(url: String)
    func promptAppReview()
}

final class SettingsViewModel {

    // MARK: Properties

    weak var output: SettingsViewModelOutputProtocol?

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
}

// MARK: - SettingsViewModelInputProtocol

extension SettingsViewModel: SettingsViewModelInputProtocol {

    func fetchSavedTheme() -> Bool {
        UserDefaults.standard.bool(forKey: themeKey)
    }

    func updateTheme(isDarkMode: Bool) {
        UserDefaults.standard.setValue(isDarkMode, forKey: themeKey)
        output?.didUpdateTheme(isDarkMode: isDarkMode)
    }

    func updateNotificationSettings(isEnabled: Bool) {
        if isEnabled {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge]
            ) { [weak self] granted, _ in
                DispatchQueue.main.async {
                    self?.output?.didFetchNotificationStatus(isEnabled: granted)
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
                output?.promptAppReview()

            case "Privacy Policy":
                output?.openExternalLink(url: "https://mertozseven.com")

            case "Terms of Use":
                output?.openExternalLink(url: "https://mertozseven.com")

            default:
                break
            }

        default:
            break
        }
    }
}
