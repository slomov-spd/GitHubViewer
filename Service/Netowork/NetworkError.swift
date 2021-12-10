//
//  NetworkError.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation

enum NetworkError: Error {
    case payloadDataMissed
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .payloadDataMissed:
            return "Payload data missed"
        }
    }
}
