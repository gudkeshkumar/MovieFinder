//
//  SearchResult.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import Foundation

struct SearchAPIResponse: Decodable {
    let search: [Movie]?
    private let totalResults: String?
    private let response: String?
    let error: String?
    
    let responseSuccess: Bool
    let totalCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
        case error = "Error"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        search = try? container.decodeIfPresent([Movie].self, forKey: .search)
        totalResults = try? container.decodeIfPresent(String.self, forKey: .totalResults)
        response = try? container.decodeIfPresent(String.self, forKey: .response)
        error = try? container.decodeIfPresent(String.self, forKey: .error)
        responseSuccess = response == "True" ? true : false
        totalCount = Int(totalResults ?? "0") ?? 0
    }
}

struct Movie: Decodable {
    let title: String?
    let yearOfRelease: String?
    let imdbID: String?
    let type: String?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case yearOfRelease = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case imageUrl = "Poster"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        yearOfRelease = try? container.decodeIfPresent(String.self, forKey: .yearOfRelease)
        imdbID = try? container.decodeIfPresent(String.self, forKey: .imdbID)
        type = try? container.decodeIfPresent(String.self, forKey: .type)
        imageUrl = try? container.decodeIfPresent(String.self, forKey: .imageUrl)
    }
}


struct MovieCellViewModel {
    let movieName: String?
    let imageURLString: String?
    let id: String?
}

extension MovieCellViewModel {
    init(_ movie: Movie) {
        movieName = movie.title
        id = movie.imdbID
        imageURLString = movie.imageUrl
    }
}
