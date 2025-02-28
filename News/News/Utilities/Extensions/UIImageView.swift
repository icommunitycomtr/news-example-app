//
//  UIImageView.swift
//  News
//
//  Created by Mert Ozseven on 22.02.2025.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(with urlString: String?, placeholder: UIImage? = nil, targetSize: CGSize? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
                .transition(.fade(0.3)),
                .memoryCacheExpiration(.seconds(300))
            ]
        )
    }
}
