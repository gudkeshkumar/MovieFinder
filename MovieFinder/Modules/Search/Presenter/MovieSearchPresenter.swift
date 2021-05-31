//
//  MovieSearchPresenter.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import Foundation


final class MovieSearchPresenter: MovieViewToPresenterProtocal {    
    
    weak var view: MoviePresenterToViewProtocol?
    
    var interactor: MoviePresenterToInteractorProtocol?
    
    var router: MoviePresenterToRouterProtocol?
    
    var movies: [MovieCellViewModel] = []
    
    func refresh() {
        
    }
    
    func numberOfItemsInSection() -> Int {
        return movies.count
    }
    
    func movie(at indexPath: IndexPath) -> MovieCellViewModel? {
        guard indexPath.item < movies.count else { return nil }
        return movies[indexPath.item]
    }
    
    func didSelectRowAt(index: Int) {
        let id = movies[index].id ?? ""
        router?.showMoviewDetails(id: id, on: view)
    }
    
    func loadMore(for searchText: String) {
        view?.startLoading()
        interactor?.fetchMoreMovies(for: searchText)
    }
    
    func fetchMovies(for searchText: String) {
        view?.startLoading()
        interactor?.fetchMovies(for: searchText)
    }
    
}

extension MovieSearchPresenter: MovieInteractorToPresenterProtocol {
    func onFetchSuccess(_ reload: Bool) {
        view?.stopLoading()
        movies = interactor?.movies?.compactMap{ MovieCellViewModel($0) } ?? []
        view?.onMoviesFetchSuccess(reload)
    }
    
    func onFailure(error: String?) {
        view?.stopLoading()
        view?.onMoviesFetchFailure(error: error)
    }
    
}
