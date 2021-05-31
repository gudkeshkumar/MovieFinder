//
//  MovieSearchInteractor.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import Foundation

final class MovieSearchInteractor: MoviePresenterToInteractorProtocol {
    
    weak var output: MovieInteractorToPresenterProtocol?
    private var page: Int = 1
    private var totalResults: Int = 0
    private let pageSize = 10
    private var numOfPages: Int {
        (totalResults / pageSize) + 1
    }
    
    var movies: [Movie]? = [Movie]()
    
    let provider = RemoteServiceProvider<MovieAPIServices>()
    
    func fetchMovies(for searchText: String) {
        resetPages()
        if searchText.trimmingCharacters(in: .whitespaces).count == 0 {
            output?.onFetchSuccess(true)
            return
        }
        let endPoint = MovieAPIServices.movies(searchText: searchText, pageNumber: 1)
        fetchMovies(endPoint)
    }
    
    func fetchMoreMovies(for searchText: String) {
        page += 1
        guard page <= numOfPages else {
            output?.onFetchSuccess(false)
            return
        }
        let endPoint = MovieAPIServices.movies(searchText: searchText, pageNumber: page)
        fetchMovies(endPoint)
        
    }
    
    private func resetPages() {
        page = 1
        totalResults = 0
        movies = []
    }
    
}

private extension MovieSearchInteractor {
    func fetchMovies(_ endPoint: MovieAPIServices) {
        provider.load(service: endPoint, decodeType: SearchAPIResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(resp):
                self.handleResponse(response: resp)
            case let .failure(error):
                self.output?.onFailure(error: error.localizedDescription)
            }
        }
    }
    
    func handleResponse(response: SearchAPIResponse) {
        guard response.error == nil else {
            output?.onFailure(error: response.error)
            return
        }
        totalResults = response.totalCount
        if page > 1 {
            movies?.append(contentsOf: response.search ?? [])
        } else {
            movies = response.search
        }
        output?.onFetchSuccess(true)
    }
}
