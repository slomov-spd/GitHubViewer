//
//  RepositoryDetailsService.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation

typealias RepositoryDetailsRequestResult = Result<RepositoryDetailsPayload, Error>
typealias RepositoryDetailsCompletion = Action<RepositoryDetailsRequestResult>

class RepositoryDetailsService: PayloadRequestService {
    
    typealias Payload = RepositoryDetailsPayload
    
    private static let url = NetworkConstants.apiBaseUrl + "repos/"
    
    static func requestDetails(
        name: String,
        owner: String,
        completion: @escaping RepositoryDetailsCompletion) {
        let fullUrl = url + owner + "/" + name
        requestPayload(url: fullUrl,
                       parameters: [:],
                       completion: completion)
    }
}
