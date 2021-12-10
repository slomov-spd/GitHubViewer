//
//  RepoStatView.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 09.12.2021.
//

import Foundation
import UIKit

struct RepoStatViewModel {
    let imageName: String
    let value: String
}

class RepoStatView: UIView, NibInstatiable {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var valueLabel: UILabel!
    
    func setupByModel(_ model: RepoStatViewModel) {
        let image = UIImage(named: model.imageName)
        
        imageView.image = image
        valueLabel.text = model.value
    }
}
