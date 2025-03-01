//
//  SettingsItem.swift
//  News
//
//  Created by Mert Ozseven on 1.03.2025.
//

import Foundation

enum SettingsSection {
    case appearance([SettingItem])
    case notifications([SettingItem])
    case general([SettingItem])
    case legal([SettingItem])
    case version([SettingItem])

    var items: [SettingItem] {
        switch self {
        case .appearance(let items),
                .notifications(let items),
                .general(let items),
                .legal(let items),
                .version(let items):
            return items
        }
    }
}

struct SettingItem {
    let title: String
    let icon: String
    let type: SettingType
}

enum SettingType {
    case theme
    case notification
    case defaultItem
}
