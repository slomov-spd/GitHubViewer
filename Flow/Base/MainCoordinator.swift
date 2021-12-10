//
//  MainCoordinator.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childs = [Coordinator]()
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigation: navigation)
        
        homeCoordinator.onRepoOpen = {
            [weak self] repo, owner in
            self?.showRepoDetails(repo: repo, owner: owner)
        }
        
        homeCoordinator.onUserOpen = {
            [weak self] login in
            self?.showUserDetails(login: login)
        }
        
        childs.append(homeCoordinator)
        homeCoordinator.start()
    }
    
    private func showRepoDetails(repo: String, owner: String) {
        let detailsCoordinator = RepoDetailsCoordinator(
            navigation: navigation,
            repoName: repo,
            ownerName: owner)
        
        detailsCoordinator.onUserOpen = {
            [weak self] login in
            self?.showUserDetails(login: login)
        }
        
        childs.append(detailsCoordinator)
        detailsCoordinator.start()
    }
    
    private func showUserDetails(login: String) {
        let detailsCoordinator = UserDetailsCoordinator(
            navigation: navigation,
            login: login)
        childs.append(detailsCoordinator)
        detailsCoordinator.start()
    }
}
