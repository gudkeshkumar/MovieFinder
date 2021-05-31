//
//  MovieDetailsPresenter.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import Foundation

final class MovieDetailsPresenter: MovieDetailsViewToPresenterProtocal {
    weak var view: MovieDetailsPresenterToViewProtocol?
    
    var interactor: MovieDetailsPresenterToInteractorProtocol?
    
    var router: MovieDetailsPresenterToRouterProtocol?
    
    var movie: MovieDetailsViewModel?
    
    private var id: String?
    
    init(with id: String?) {
        self.id = id
    }
    
    func viewDidLoad() {
        interactor?.fetchDetails(for: id)
    }
    
}

extension MovieDetailsPresenter: MovieDetailsInteractorToPresenterProtocol {
    func onDetailsFetchSuccess(data: MovieDetail) {
        movie = MovieDetailsViewModel(data)
        view?.onMovieDetailsFetchSuccess()
    }
    
   
    func onDetailsFetchFailure(error: String?) {
        view?.onMovieDetailsFetchFailure(error: error)
    }
}
