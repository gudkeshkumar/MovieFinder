//
//  SearchResult.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import Foundation

final class MovieDetailsInteractor: MovieDetailsPresenterToInteractorProtocol {
    weak var output: MovieDetailsInteractorToPresenterProtocol?
    var details: MovieDetail?
    
    let provider = RemoteServiceProvider<MovieAPIServices>()
    
    func fetchDetails(for id: String?) {
        guard let id = id else {
            output?.onDetailsFetchFailure(error: "ID must not be nil")
            return
        }
        let endPoint = MovieAPIServices.movieDetails(id: id)
        fetchMoviesDetails(endPoint)
    }
    
}

private extension MovieDetailsInteractor {
    func fetchMoviesDetails(_ endPoint: MovieAPIServices) {
        provider.load(service: endPoint, decodeType: MovieDetail.self) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(resp):
                self.handleResponse(response: resp)
            case let .failure(error):
                self.output?.onDetailsFetchFailure(error: error.localizedDescription)
            }
        }
    }
    
    func handleResponse(response: MovieDetail) {
        guard response.error == nil else {
            output?.onDetailsFetchFailure(error: response.error)
            return
        }
        details = response
        output?.onDetailsFetchSuccess(data: response)
    }
}
