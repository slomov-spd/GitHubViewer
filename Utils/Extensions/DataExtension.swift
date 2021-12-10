//
//  DataExtension.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation

extension Data {
    func toPayload<T: Decodable> () throws -> T {
        try JSONDecoder.apiDecoder.decode(T.self, from: self)
    }
}
