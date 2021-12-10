//
//  RepositoryDetailsPayload.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation

struct RepositoryOwnerPayload: Codable {
    let login: String
    let avatarUrl: String
}

struct RepositoryLicensePayload: Codable {
    let name: String
}

struct RepositoryDetailsPayload: Codable {
    let owner: RepositoryOwnerPayload
    let name: String
    let htmlUrl: String
    let updatedAt: Date
    let forksCount: Int
    let stargazersCount: Int
    let openIssuesCount: Int
    let watchersCount: Int
    let subscribersCount: Int
    let language: String?
    let license: RepositoryLicensePayload?
}
