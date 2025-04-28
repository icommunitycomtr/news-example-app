//
//  SettingsItem.swift
//  News
//
//  Created by Mert Ozseven on 1.03.2025.
//

import Foundation

enum SettingSectionType {
    case theme
    case notification
    case rateApp
    case privacyPolicy
    case termsOfUse
    case version
}

struct SettingItem {
    let title: String
    let iconName: String
    let type: SettingSectionType
}

struct SettingsSection {
    let title: String
    let items: [SettingItem]
}
