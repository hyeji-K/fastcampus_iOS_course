//
//  NetworkService.swift
//  GithubSearch
//
//  Created by heyji on 2022/06/30.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case responseError(statusCode: Int)
    case jsonDecodingError(error: Error)
}
