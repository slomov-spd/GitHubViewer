//
//  OrderSwitcher.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 09.12.2021.
//

import UIKit

enum OrderSwitcherState {
    case ascending, descending
}

class OrderSwitcher: UIView {
    
    private enum ImagesNames {
        static let ascending = "ascending"
        static let descending = "descending"
    }
    
    var onChange: Action<OrderSwitcherState>?
    var state = OrderSwitcherState.descending {
        didSet { updateImage() }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        let constraints = NSLayoutConstraint.equalBorders(self, imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        switch state {
        case .ascending:
            state = .descending
        case .descending:
            state = .ascending
        }
        
        onChange?(state)
    }
    
    private func updateImage() {
        switch state {
        case .ascending:
            let image = UIImage(named: ImagesNames.ascending)
            imageView.image = image
        case .descending:
            let image = UIImage(named: ImagesNames.descending)
            imageView.image = image
        }
    }
}
