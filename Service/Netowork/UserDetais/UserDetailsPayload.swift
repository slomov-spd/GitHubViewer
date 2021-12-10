//
//  UserDetailsPayload.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation

struct UserDetailsPayload: Codable {
    let login: String
    let name: String?
    let avatarUrl: String
    let htmlUrl: String
    let type: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
}
