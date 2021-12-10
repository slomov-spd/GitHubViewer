//
//  SetupableCell.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit

protocol SetupableCell: UITableViewCell, NibInstatiable {
    associatedtype Model: CellViewModel
    
    static var reuseId: String { get }
    
    func setupBy(_ model: Model)
}

extension SetupableCell {
    static var reuseId: String {
        String(describing: self)
    }
}
