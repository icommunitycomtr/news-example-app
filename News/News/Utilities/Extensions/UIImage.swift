//
//  UIImage.swift
//  News
//
//  Created by Mert Ozseven on 18.02.2025.
//

import UIKit

extension UIImage {

    /// UIImage extension to resize image
    /// - Parameters:
    /// - targetSize: CGSize
    func resized(to targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let newImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }

        return newImage
    }
}
