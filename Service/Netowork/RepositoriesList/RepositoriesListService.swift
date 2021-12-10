//
//  RepositoriesListService.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation
import Alamofire

typealias RepositoriesListRequestResult = Result<RepositoriesListPayload, Error>
typealias RepositoriesListCompletion = Action<RepositoriesListRequestResult>

class RepositoriesListService: PayloadRequestService {

    typealias Payload = RepositoriesListPayload
    
    private static let url = NetworkConstants.apiBaseUrl + "search/repositories"
    
    static func requestList(
        query: String,
        sort: RepositoriesListSort,
        order: RepositoriesListOrder,
        completion: @escaping RepositoriesListCompletion) {
            
            let params = ["q" : query,
                          "sort" : sort.rawValue,
                          "order" : order.rawValue]
            
            requestPayload(url: url,
                           parameters: params,
                           completion: completion)
    }
}
