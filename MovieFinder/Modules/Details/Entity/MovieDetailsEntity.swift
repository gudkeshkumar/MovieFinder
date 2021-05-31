//
//  MovieDetailsEntity.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import Foundation

struct MovieDetail: Decodable {
    let title: String?
    let year: String?
    let rated: String?
    let released: String?
    let runTime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let language: String?
    let country: String?
    let awards: String?
    let poster: String?
    let metaScore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let type: String?
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String?
    let error: String?
    let ratings: [Rating]?
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runTime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case metaScore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case imdbID = "imdbID"
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case error = "Error"
        case ratings = "Ratings"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        year = try container.decodeIfPresent(String.self, forKey: .year)
        rated = try container.decodeIfPresent(String.self, forKey: .rated)
        released = try container.decodeIfPresent(String.self, forKey: .released)
        runTime = try container.decodeIfPresent(String.self, forKey: .runTime)
        genre = try container.decodeIfPresent(String.self, forKey: .genre)
        director = try container.decodeIfPresent(String.self, forKey: .director)
        writer = try container.decodeIfPresent(String.self, forKey: .writer)
        actors = try container.decodeIfPresent(String.self, forKey: .actors)
        plot = try container.decodeIfPresent(String.self, forKey: .plot)
        language = try container.decodeIfPresent(String.self, forKey: .language)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        awards = try container.decodeIfPresent(String.self, forKey: .awards)
        poster = try container.decodeIfPresent(String.self, forKey: .poster)
        metaScore = try container.decodeIfPresent(String.self, forKey: .metaScore)
        imdbRating = try container.decodeIfPresent(String.self, forKey: .imdbRating)
        imdbVotes = try container.decodeIfPresent(String.self, forKey: .imdbVotes)
        imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        dvd = try container.decodeIfPresent(String.self, forKey: .dvd)
        boxOffice = try container.decodeIfPresent(String.self, forKey: .boxOffice)
        production = try container.decodeIfPresent(String.self, forKey: .production)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        error = try container.decodeIfPresent(String.self, forKey: .error)
        response = try container.decodeIfPresent(String.self, forKey: .response)
        ratings = try container.decodeIfPresent([Rating].self, forKey: .ratings)
    }
 
}

struct Rating: Decodable {
    let source: String?
    let value: String?
    
    private enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        value = try container.decodeIfPresent(String.self, forKey: .value)
    }
}

struct MovieDetailsViewModel {
    let imageURL: String?
    let title: String?
    let year: String?
    let runTime: String?
    let genre: String?
    let director: String?
    let writer: String?
    let actors: String?
    let plot: String?
    let imdbRating: String?
}

extension MovieDetailsViewModel {
    
    init(_ detail: MovieDetail) {
        imageURL = detail.poster
        title = detail.title
        year = detail.year
        runTime = detail.runTime
        genre = detail.genre
        imdbRating = detail.imdbRating
        plot = detail.plot
        director = detail.director
        actors = detail.actors
        writer = detail.writer
    }
}
