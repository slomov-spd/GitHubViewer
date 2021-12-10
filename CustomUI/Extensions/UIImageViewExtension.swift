//
//  UIImageViewExtension.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 09.12.2021.
//

import UIKit

extension UIImageView {
    func applyAvatarStyle() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true
    }
    
    func loadFromPath(_ path: String?) {
        guard let path = path,
              let url = URL(string: path) else {
                  self.image = nil
            return
        }
        
        let activity = UIActivityIndicatorView(style: .medium)
        addSubview(activity)
        activity.centerIntoSuperView()
        activity.startAnimating()
        
        DispatchQueue.global().async {
            [weak self, weak activity] in
            
            guard let imageData = try? Data(contentsOf: url) else {
                activity?.removeFromSuperview()
                return
            }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.image = image
                activity?.removeFromSuperview()
            }
        }
    }
}
