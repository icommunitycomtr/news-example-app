//
//  OpenInBrowserActivity.swift
//  News
//
//  Created by Mert Ozseven on 22.02.2025.
//

import UIKit

final class OpenInBrowserActivity: UIActivity {
    private var url: URL?

    override var activityTitle: String? {
        "Open in Browser"
    }

    override var activityImage: UIImage? {
        UIImage(systemName: "safari")
    }

    override var activityType: UIActivity.ActivityType? {
        UIActivity.ActivityType("com.mertozseven.openinbrowser")
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        activityItems.contains { $0 is URL }
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        url = activityItems.first(where: { $0 is URL }) as? URL
    }

    override func perform() {
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        activityDidFinish(true)
    }
}
