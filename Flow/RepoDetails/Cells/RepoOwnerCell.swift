//
//  RepoOwnerCell.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit

struct RepoOwnerCellViewModel: CellViewModel {
    
    typealias Cell = RepoOwnerCell
    
    let name: String
    let avatarUrl: String?
}

class RepoOwnerCell: UITableViewCell, SetupableCell {
    
    typealias Model = RepoOwnerCellViewModel
    
    private enum ImageNames {
        static let avatarStub = "avatarStuv"
    }
    
    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func setupBy(_ model: Model) {
        nameLabel.text = model.name
        
        if let url = model.avatarUrl {
            avatarView.loadFromPath(url)
        } else {
            let imageName = ImageNames.avatarStub
            avatarView.image = UIImage(named: imageName)
        }
    }
}
