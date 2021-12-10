//
//  UserDetailsService.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 10.12.2021.
//

import Foundation

typealias UserDetailsRequestResult = Result<UserDetailsPayload, Error>
typealias UserDetailsCompletion = Action<UserDetailsRequestResult>

class UserDetailsService: PayloadRequestService {
    
    typealias Payload = UserDetailsPayload
    
    private static let url = NetworkConstants.apiBaseUrl + "users/"
    
    static func requestDetails(
        login: String,
        completion: @escaping UserDetailsCompletion) {
        let fullUrl = url + login
        requestPayload(url: fullUrl,
                       parameters: [:],
                       completion: completion)
    }
}
