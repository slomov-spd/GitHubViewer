//
//  RepoDetailsViewModel.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation

struct RepoDetailsViewModel {
    var name: String
    var externalUrl: String
    var owner: RepoOwnerCellViewModel
    var info: [KeyValueCellViewModel]
}
