//
//  UserDetailsViewModel.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation

struct UserDetailsViewModel {
    var name: String
    var externalUrl: String
    var avatarUrl: String
    var info: [KeyValueCellViewModel]
}
