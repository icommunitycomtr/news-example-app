//
//  SettingsViewModel.swift
//  News
//
//  Created by Mert Ozseven on 7.02.2025.
//

import Foundation
import UserNotifications

protocol SettingsViewModelInputProtocol: AnyObject {
    func fetchThemeMode() -> Int
    func updateThemeMode(_ mode: Int)
    func updateNotification(isOn: Bool)
    func fetchNotificationStatus(_ completion: @escaping (Bool) -> Void)
    func didSelect(item: SettingItem)
}

final class SettingsViewModel {
    weak var inputDelegate: SettingsViewModelInputProtocol?
    weak var outputDelegate: SettingsViewModelOutputProtocol?

    private let themeKey = "selectedTheme"

    var appVersionText: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "?"
        let bundle = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "?"
        return "Version \(version) (\(bundle))"
    }

    lazy var sections: [SettingsSection] = [
        SettingsSection(title: "Appearance", items: [
            SettingItem(title: "App Theme", iconName: "circle.righthalf.filled", type: .theme)
        ]),
        SettingsSection(title: "Notifications", items: [
            SettingItem(title: "Notification", iconName: "bell.fill", type: .notification)
        ]),
        SettingsSection(title: "General", items: [
            SettingItem(title: "Rate Us", iconName: "star.fill", type: .rateApp)
        ]),
        SettingsSection(title: "Legal", items: [
            SettingItem(title: "Privacy Policy", iconName: "text.document.fill", type: .privacyPolicy),
            SettingItem(title: "Terms of Use", iconName: "checkmark.shield.fill", type: .termsOfUse)
        ]),
        SettingsSection(title: "Version", items: [
            SettingItem(title: appVersionText, iconName: "", type: .version)
        ])
    ]

    init() {
        inputDelegate = self
    }
}

extension SettingsViewModel: SettingsViewModelInputProtocol {
    func fetchThemeMode() -> Int {
        UserDefaults.standard.integer(forKey: themeKey)
    }

    func updateThemeMode(_ mode: Int) {
        UserDefaults.standard.set(mode, forKey: themeKey)
        outputDelegate?.didUpdateTheme(mode)
    }

    func updateNotification(isOn: Bool) {
        guard isOn else {
            outputDelegate?.didUpdateNotification(false)
            return
        }
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            DispatchQueue.main.async {
                self?.outputDelegate?.didUpdateNotification(granted)
            }
        }
    }

    func fetchNotificationStatus(_ completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { status in
            DispatchQueue.main.async {
                completion(status.authorizationStatus == .authorized)
            }
        }
    }

    func didSelect(item: SettingItem) {
        switch item.type {
        case .rateApp: outputDelegate?.promptReview()
        case .privacyPolicy: outputDelegate?.openURL("https://mertozseven.com")
        case .termsOfUse: outputDelegate?.openURL("https://mertozseven.com")
        default: break
        }
    }
}
