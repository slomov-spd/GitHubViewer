//
//  HomeInteractor.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation
import SwiftDate

protocol HomeInteractorDelegate: AnyObject {
    func interactorFinishWithError(_ error: String)
    func intercatoFinishSuccessfully(_ model: HomeViewModel)
}

protocol HomeInteractorProtocol {
    var delegate: HomeInteractorDelegate? { get set }
    
    func getRepositories(query: String,
                         sort: HomeViewSort,
                         order: HomeViewOrder)
}

class HomeInteractor: HomeInteractorProtocol {

    private enum ImageNames {
        static let stars = "stars"
        static let watchers = "watchers"
        static let forks = "forks"
        static let issues = "issues"
    }
    
    weak var delegate: HomeInteractorDelegate?
    
    func getRepositories(query: String,
                         sort: HomeViewSort,
                         order: HomeViewOrder) {
        RepositoriesListService.requestList(
            query: query,
            sort: convertSort(sort),
            order: convertOrder(order)) {
                [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                case .success(let payload):
                    let repos = self.convertRepos(payload.items)
                    
                    let model = HomeViewModel()
                    model.order = order
                    model.sort = sort
                    model.query = query
                    model.repos = repos
                    
                    self.delegate?.intercatoFinishSuccessfully(model)
                    
                case .failure(let error):
                    let message = error.localizedDescription
                    self.delegate?.interactorFinishWithError(message)
                }
            }
    }
    
    private func convertSort(_ sort: HomeViewSort) -> RepositoriesListSort {
        switch sort {
        case .updated: return .updated
        case .stars: return .stars
        case .forks: return .forks
        }
    }
    
    private func convertSort(_ sort: RepositoriesListSort) -> HomeViewSort {
        switch sort {
        case .updated: return .updated
        case .stars: return .stars
        case .forks: return .forks
        }
    }
    
    private func convertOrder(_ order: RepositoriesListOrder) -> HomeViewOrder {
        switch order {
        case .descending: return .descending
        case .ascending: return .ascending
        }
    }
    
    private func convertOrder(_ order: HomeViewOrder) -> RepositoriesListOrder {
        switch order {
        case .descending: return .descending
        case .ascending: return .ascending
        }
    }
            
    private func convertRepos(_ repos: [RepositoriesListNode]) -> [RepositoriesListCellViewModel] {
        return repos.map { convertRepo($0) }
    }
    
    private func convertRepo(_ repo: RepositoriesListNode) -> RepositoriesListCellViewModel {
        
        let stars = RepoStatViewModel(
            imageName: ImageNames.stars,
            value: "\(repo.stargazersCount)")
        
        let forks = RepoStatViewModel(
            imageName: ImageNames.forks,
            value: "\(repo.forksCount)")
        
        let watchers = RepoStatViewModel(
            imageName: ImageNames.watchers,
            value: "\(repo.watchersCount)")
        
        let issues = RepoStatViewModel(
            imageName: ImageNames.issues,
            value: "\(repo.openIssuesCount)")
        
        let updateStyle = RelativeFormatter.defaultStyle()
        let updated = repo.updatedAt.toRelative(
            style: updateStyle,
            locale: Locales.current)
        
        return RepositoriesListCellViewModel(
            stats: [stars, watchers, forks, issues],
            updatedAt: updated,
            name: repo.name,
            ownerName: repo.owner.login,
            ownerAvatarUrl: repo.owner.avatarUrl)
    }
}
