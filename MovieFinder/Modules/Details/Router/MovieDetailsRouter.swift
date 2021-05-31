//
//  MovieDetailsRouter.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import UIKit

final class MovieDetailsRouter: MovieDetailsPresenterToRouterProtocol {
    
    static func createModule(with movieID: String?) -> UIViewController {
        let view: MovieDetailsViewController =  MovieDetailsViewController.instantiate(from: .main)
        let presenter = MovieDetailsPresenter(with: movieID)
        let interactor = MovieDetailsInteractor()
        let router = MovieDetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.router = router
        
        return view
    }
}
