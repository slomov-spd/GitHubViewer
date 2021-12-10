//
//  RepoDetailsInteractor.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation
import SwiftDate

protocol RepoDetailsInteractorDelegate {
    func interactorFinishWithError(_ error: String)
    func intercatoFinishSuccessfully(_ model: RepoDetailsViewModel)
}

protocol RepoDetailsInteractorProtocol {
    var delegate: RepoDetailsInteractorDelegate? { get set }
    
    func requestDetails(repoName: String, ownerName: String)
}

class RepoDetailsInteractor: RepoDetailsInteractorProtocol {
    
    var delegate: RepoDetailsInteractorDelegate?
    
    func requestDetails(repoName: String, ownerName: String) {
        
        RepositoryDetailsService.requestDetails(
            name: repoName,
            owner: ownerName) {
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
    
    private func handlePayload(_ payload: RepositoryDetailsPayload) {
        let ownerModel = RepoOwnerCellViewModel(
            name: payload.owner.login,
            avatarUrl: payload.owner.avatarUrl)
        
        var info = [KeyValueCellViewModel]()
        
        let updateStyle = RelativeFormatter.defaultStyle()
        let updatedString = payload.updatedAt.toRelative(
            style: updateStyle,
            locale: Locales.current)
        let updatedAt = KeyValueCellViewModel(
            key: "Updated".localized(),
            value: updatedString)
        info.append(updatedAt)
        
        let forksCount = KeyValueCellViewModel(
            key: "Forks".localized(),
            value: "\(payload.forksCount)")
        info.append(forksCount)
        
        let stargazersCount = KeyValueCellViewModel(
            key: "Stars".localized(),
            value: "\(payload.stargazersCount)")
        info.append(stargazersCount)
        
        let openIssuesCount = KeyValueCellViewModel(
            key: "Open issues".localized(),
            value: "\(payload.openIssuesCount)")
        info.append(openIssuesCount)
        
        let watchersCount = KeyValueCellViewModel(
            key: "Watchers".localized(),
            value: "\(payload.watchersCount)")
        info.append(watchersCount)
        
        let subscribersCount = KeyValueCellViewModel(
            key: "Subscribers".localized(),
            value: "\(payload.subscribersCount)")
        info.append(subscribersCount)
        
        if let payloadLanguage = payload.language {
            let language = KeyValueCellViewModel(
                key: "Language".localized(),
                value: payloadLanguage)
            info.append(language)
        }
        
        if let payloadLicense = payload.license {
            let license = KeyValueCellViewModel(
                key: "License".localized(),
                value: payloadLicense.name)
            info.append(license)
        }
        
        let model = RepoDetailsViewModel(
            name: payload.name,
            externalUrl: payload.htmlUrl,
            owner: ownerModel,
            info: info)
        
        delegate?.intercatoFinishSuccessfully(model)
    }
}
