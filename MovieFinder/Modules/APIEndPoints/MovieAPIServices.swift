//
//  MovieAPIServices.swift
//  MovieFinder
//
//  Created by apple on 05/04/21.
//

import Foundation


enum MovieAPIServices {
    case movies(searchText: String, pageNumber: Int = 1)
    case movieDetails(id: String)
}

extension MovieAPIServices: APIService {
    
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: String {
        return "http://www.omdbapi.com/"
    }

    var path: String {
        return ""
    }

    var parameters: [String: Any]? {
        // default params
        var params: [String: Any] = ["apikey": "b9bd48a6"]
        
        switch self {
        case let .movies(searchText, pageNumber):
            params["s"] = searchText
            params["page"] = "\(pageNumber)"
        case let .movieDetails(id):
            params["i"] = id
        }
        return params
    }

    var method: HTTPMethod {
        return .get
    }
}
