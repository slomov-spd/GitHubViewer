//
//  HomeViewModel.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation

enum HomeViewSort {
    case updated, stars, forks
    
    var title: String {
        switch self {
        case .updated:
            return "updated date".localized()
        case .stars:
            return "stars count".localized()
        case .forks:
            return "forks count".localized()
        }
    }
}

enum HomeViewOrder {
    case ascending, descending
}

struct RepositoriesListCellViewModel: CellViewModel {
    typealias Cell = RepositoriesListCell
    
    let stats: [RepoStatViewModel]
    let updatedAt: String
    let name: String
    let ownerName: String
    let ownerAvatarUrl: String
}

class HomeViewModel {
    var query: String = ""
    var sort = HomeViewSort.updated
    var order = HomeViewOrder.ascending
    var repos = [RepositoriesListCellViewModel]()
}
