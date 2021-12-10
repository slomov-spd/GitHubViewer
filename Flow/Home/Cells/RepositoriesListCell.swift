//
//  RepositoriesListCell.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation
import UIKit

protocol RepositoriesListCellDelegate: AnyObject {
    func userAvatarDidTapped(_ name: String)
}

class RepositoriesListCell: UITableViewCell, SetupableCell {
    
    typealias Model = RepositoriesListCellViewModel
    
    weak var delegate: RepositoriesListCellDelegate?
    private var ownerName: String?
    
    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ownerLabel: UILabel!
    @IBOutlet private weak var statsView: RepoStatsView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarView.applyAvatarStyle()
        avatarView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarView.addGestureRecognizer(tap)
    }
    
    func setupBy(_ model: RepositoriesListCellViewModel) {
        ownerName = model.ownerName
        
        avatarView.loadFromPath(model.ownerAvatarUrl)
        nameLabel.text = model.name
        ownerLabel.text = model.ownerName
        statsView.showStats(model.stats)
    }
    
    @objc private func avatarTapped() {
        guard let ownerName = ownerName else {
            return
        }
        delegate?.userAvatarDidTapped(ownerName)
    }
}
