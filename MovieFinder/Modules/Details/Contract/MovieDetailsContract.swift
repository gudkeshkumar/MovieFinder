//
//  MovieDetailsContract.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import UIKit

//MARK: ViewBehavior (Presenter to view Protocol)
protocol  MovieDetailsPresenterToViewProtocol: class {
    func onMovieDetailsFetchSuccess()
    func onMovieDetailsFetchFailure(error: String?)
    func startLoading()
    func stopLoading()
}

//MARK: View to Presenter
protocol MovieDetailsViewToPresenterProtocal {
    var view: MovieDetailsPresenterToViewProtocol? { get set }
    var interactor: MovieDetailsPresenterToInteractorProtocol? { get set }
    var router: MovieDetailsPresenterToRouterProtocol? { get set }
    var movie: MovieDetailsViewModel? { get set }
    func viewDidLoad()
}

//MARK: Presnetr to Router
protocol MovieDetailsPresenterToRouterProtocol {
    static func createModule(with movieID: String?) -> UIViewController
}

//MARK: Presenter to Interactor
protocol MovieDetailsPresenterToInteractorProtocol {
    func fetchDetails(for id: String?)
}

//MARK: Interactor to Presenter
protocol MovieDetailsInteractorToPresenterProtocol: class {
    func onDetailsFetchSuccess(data: MovieDetail)
    func onDetailsFetchFailure(error: String?)
}
