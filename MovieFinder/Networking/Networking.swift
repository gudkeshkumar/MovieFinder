//
//  Networking.swift
//  MovieFinder
//
//  Created by apple on 02/04/21.
//

import Foundation

enum ResponseError: Error {
    case error(message: String)
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case update = "UPDATE"
}

protocol APIService {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
}

extension APIService {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        return request
    }

    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path

        if method == .get {
            // add query items to url
            guard let parameters = parameters as? [String: String] else {
                fatalError("parameters for GET http method must be [String: String]")
            }
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        return urlComponents?.url
    }
}
