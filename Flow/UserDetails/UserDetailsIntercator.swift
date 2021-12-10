//
//  UserDetailsIntercator.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation

protocol UserDetailsInteractorDelegate {
    func interactorFinishWithError(_ error: String)
    func intercatoFinishSuccessfully(_ model: UserDetailsViewModel)
}

protocol UserDetailsInteractorProtocol {
    var delegate: UserDetailsInteractorDelegate? { get set }
    
    func requestDetails(login: String)
}

class UserDetailsInteractor: UserDetailsInteractorProtocol {
    
    var delegate: UserDetailsInteractorDelegate?
    
    func requestDetails(login: String) {
        
        UserDetailsService.requestDetails(login: login) {
            [weak self] result in
                
            switch result {
            case .success(let payload):
                self?.handlePayload(payload)
            case .failure(let error):
                let message = error.localizedDescription
                self?.delegate?.interactorFinishWithError(message)
            }
        }
    }
    
    private func handlePayload(_ payload: UserDetailsPayload) {
    
        var info = [KeyValueCellViewModel]()
        
        let type = KeyValueCellViewModel(
            key: "Type".localized(),
            value: payload.type)
        info.append(type)
        
        let publicRepos = KeyValueCellViewModel(
            key: "Public repos".localized(),
            value: "\(payload.publicRepos)")
        info.append(publicRepos)
        
        let publicGists = KeyValueCellViewModel(
            key: "Public gists".localized(),
            value: "\(payload.publicGists)")
        info.append(publicGists)
        
        let followers = KeyValueCellViewModel(
            key: "Followers".localized(),
            value: "\(payload.followers)")
        info.append(followers)
        
        let following = KeyValueCellViewModel(
            key: "Following".localized(),
            value: "\(payload.following)")
        info.append(following)
        
        let model = UserDetailsViewModel(
            name: payload.name ?? payload.login,
            externalUrl: payload.htmlUrl,
            avatarUrl: payload.avatarUrl,
            info: info)
        delegate?.intercatoFinishSuccessfully(model)
    }
}
