//
//  KeyValueCell.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit

struct KeyValueCellViewModel: CellViewModel {
    
    typealias Cell = KeyValueCell
    
    let key: String
    let value: String
}

class KeyValueCell: UITableViewCell, SetupableCell {
    
    typealias Model = KeyValueCellViewModel
    
    @IBOutlet private weak var keyLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    func setupBy(_ model: KeyValueCellViewModel) {
        keyLabel.text = model.key
        valueLabel.text = model.value
    }
}
