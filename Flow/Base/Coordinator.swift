//
//  Coordinator.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import UIKit

protocol Coordinator {
    var childs: [Coordinator] { get set }
    var navigation: UINavigationController { get set }

    func start()
}

extension Coordinator {
    func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Error".localized(),
            message: message,
            preferredStyle: .alert)
        alert.addAction(.ok)
        self.navigation.present(alert, animated: true)
    }
}
