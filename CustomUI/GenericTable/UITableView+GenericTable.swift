//
//  UITableView.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit

extension UITableView {
    
    func register<T: SetupableCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: T.nibName,
                        bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseId)
    }
    
    func dequeue<VM: CellViewModel>(model: VM) -> VM.Cell? {
        let cell = dequeueReusableCell(withIdentifier: VM.Cell.reuseId)
        
        if let setupable = cell as? VM.Cell {
            setupable.setupBy(model)
        }
        
        return cell as? VM.Cell
    }
}
