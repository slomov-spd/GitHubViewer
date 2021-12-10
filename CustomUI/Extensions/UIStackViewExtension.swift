//
//  UIStackViewExtension.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 09.12.2021.
//

import UIKit

extension UIStackView {
    func clear() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
