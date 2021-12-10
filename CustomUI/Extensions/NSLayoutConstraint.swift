//
//  NSLayoutConstraint.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 09.12.2021.
//

import UIKit

extension NSLayoutConstraint {
    convenience init(_ attribute: Attribute,
                     _ first: UIView,
                     _ second: UIView,
                     constant: CGFloat = 0) {
        self.init(item: first,
                  attribute: attribute,
                  relatedBy: .equal,
                  toItem: second,
                  attribute: attribute,
                  multiplier: 1,
                  constant: constant)
    }
    
    static func equalBorders(_ first: UIView,
                             _ second: UIView,
                             gap: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            .init(.leading, first, second, constant: gap),
            .init(.trailing, first, second, constant: -gap),
            .init(.top, first, second, constant: gap),
            .init(.bottom, first, second, constant: -gap),
            ]
    }
}
