//
//  Actions.swift
//  GitHubViewer
//
//  Created by Serhii.Lomov on 08.12.2021.
//

import Foundation

typealias Action<T> = (T) -> Void

typealias VoidAction = () -> Void
typealias StringAction = Action<String>
typealias BoolAction = Action<Bool>
