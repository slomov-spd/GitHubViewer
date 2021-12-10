//
//  PayloadRequestService.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation
import Alamofire

protocol PayloadRequestService {
    associatedtype Payload: Decodable
    
    typealias Completion = Action<Result<Payload, Error>>
    
    static func requestPayload(url: URLConvertible,
                               parameters: Parameters,
                               completion: @escaping Completion)
}

extension PayloadRequestService {
    static func requestPayload(url: URLConvertible,
                               parameters: Parameters,
                               completion: @escaping Completion) {
        AF.request(url, parameters: parameters).response {
            response in
            
            switch response.result {
            case .success(let data):
                handleData(data: data, completion: completion)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private static func handleData(data: Data?,
                                   completion: @escaping Completion) {
        guard let data = data else {
            let error = NetworkError.payloadDataMissed
            completion(.failure(error))
            return
        }
        
        do {
            let payload: Payload  = try data.toPayload()
            completion(.success(payload))
        } catch let error {
            completion(.failure(error))
        }
    }
}
