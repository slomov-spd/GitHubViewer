//
//  NibInstatiable.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import UIKit

protocol NibInstatiable {
    static var nibName: String { get }
    
    static func instantiate() -> Self
}

extension NibInstatiable where Self: UIView {
    static var nibName: String { String(describing: self) }
    
    static func instantiate() -> Self {
        let nib = UINib(nibName: nibName, bundle: nil)
        let views = nib.instantiate(withOwner: self, options: nil)
        return views.first as! Self
    }
}

extension NibInstatiable where Self: UIViewController {
    static var nibName: String { String(describing: self) }
    
    static func instantiate() -> Self {
        return Self.init(nibName: nibName, bundle: nil)
    }
}

extension UIViewController: NibInstatiable {}
