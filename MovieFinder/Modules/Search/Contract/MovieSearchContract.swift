//
//  MovieSearchContract.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import UIKit

//MARK: ViewBehavior (Presenter to view Protocol)
protocol MoviePresenterToViewProtocol: class {
    func onMoviesFetchSuccess(_ reload: Bool)
    func onMoviesFetchFailure(error: String?)
    func startLoading()
    func stopLoading()
}

//MARK: View to Presenter
protocol MovieViewToPresenterProtocal {
    var view: MoviePresenterToViewProtocol? { get set }
    var interactor: MoviePresenterToInteractorProtocol? { get set }
    var router: MoviePresenterToRouterProtocol? { get set }
    var movies: [MovieCellViewModel] { get set }
    func refresh()
    func numberOfItemsInSection() -> Int
    func movie(at indexPath: IndexPath) -> MovieCellViewModel?
    func didSelectRowAt(index: Int)
    func loadMore(for searchText: String)
    func fetchMovies(for searchText: String)
}

//MARK: Presnetr to Router
protocol MoviePresenterToRouterProtocol {
    static func createModule() -> UINavigationController
    func showMoviewDetails(id: String, on view: MoviePresenterToViewProtocol?)
}

//MARK: Presenter to Interactor
protocol MoviePresenterToInteractorProtocol {
    var output: MovieInteractorToPresenterProtocol? { get set }
    var movies: [Movie]? { get set }
    func fetchMovies(for searchText: String)
    func fetchMoreMovies(for searchText: String)
}

//MARK: Interactor to Presenter
protocol MovieInteractorToPresenterProtocol: class {
    func onFetchSuccess(_ reload: Bool)
    func onFailure(error: String?)
}

