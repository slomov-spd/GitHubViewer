//
//  RepositoriesListPayload.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation

struct RepositoriesListNodeOwner: Codable {
    let login: String
    let avatarUrl: String
}

struct RepositoriesListNode: Codable {
    let name: String
    let owner: RepositoriesListNodeOwner
    let updatedAt: Date
    let forksCount: Int
    let stargazersCount: Int
    let openIssuesCount: Int
    let watchersCount: Int
}

struct RepositoriesListPayload: Codable {
    let items: [RepositoriesListNode]
}
