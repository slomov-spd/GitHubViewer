//
//  CellViewModel.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import UIKit

protocol CellViewModel {
    associatedtype Cell: SetupableCell where Cell.Model == Self
}
