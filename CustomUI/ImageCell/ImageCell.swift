//
//  ImageCell.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation
import UIKit

struct ImageCellViewModel: CellViewModel {
    
    typealias Cell = ImageCell
    
    let size: CGFloat
    let imageUrl: String
}

class ImageCell: UITableViewCell, SetupableCell {
    
    typealias Model = ImageCellViewModel
    
    @IBOutlet private weak var centerImageView: UIImageView!
    @IBOutlet private weak var sizeConstraint: NSLayoutConstraint!
    
    func setupBy(_ model: ImageCellViewModel) {
        centerImageView.loadFromPath(model.imageUrl)
        sizeConstraint.constant = model.size
    }
}
