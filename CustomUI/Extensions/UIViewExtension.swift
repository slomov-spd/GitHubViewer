//
//  UIViewExtension.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 09.12.2021.
//

import UIKit

extension UIView {
    func centerIntoSuperView() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
}
