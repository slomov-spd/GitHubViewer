//
//  RepoStatsView.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 09.12.2021.
//

import Foundation
import UIKit

class RepoStatsView: UIView {
    
    private lazy var statsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stack)
        let constraints = NSLayoutConstraint.equalBorders(self, stack)
        NSLayoutConstraint.activate(constraints)
        
        return stack
    }()
    
    func showStats(_ stats: [RepoStatViewModel]) {
        statsStack.clear()
        
        for stat in stats {
            let view = RepoStatView.instantiate()
            view.setupByModel(stat)
            statsStack.addArrangedSubview(view)
        }
    }
}
