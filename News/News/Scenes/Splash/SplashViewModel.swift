//
//  SplashViewModel.swift
//  News
//
//  Created by Mert Ozseven on 28.04.2025.
//

import Foundation

protocol SplashInputProtocol: AnyObject {
    func splashScreenLoaded()
}

final class SplashViewModel {
    weak var inputDelegate: SplashInputProtocol?
    weak var outputDelegate: SplashOutputProtocol?

    init() { inputDelegate = self }
}

extension SplashViewModel: SplashInputProtocol {

    func splashScreenLoaded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.outputDelegate?.transitionToMainScene()
        }
    }
}
