//
//  RepositoriesListEnum.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation

enum RepositoriesListSort: String {
    case stars = "stars"
    case forks = "forks"
    case updated = "updated"
}

enum RepositoriesListOrder: String {
    case descending = "desc"
    case ascending = "asc"
}
