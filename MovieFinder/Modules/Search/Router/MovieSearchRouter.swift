//
//  MovieSearchRouter.swift
//  MovieFinder
//
//  Created by apple on 01/04/21.
//

import UIKit

final class MovieSearchRouter: MoviePresenterToRouterProtocol {
    static func createModule() -> UINavigationController {
        let viewController = MovieSearchViewController()
        let presenter = MovieSearchPresenter()
        let interactor = MovieSearchInteractor()
        let router = MovieSearchRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func showMoviewDetails(id: String, on view: MoviePresenterToViewProtocol?) {
        guard let vc = view as? MovieSearchViewController else { return }
        let presentedVC = MovieDetailsRouter.createModule(with: id)
        vc.navigationController?.show(presentedVC, sender: nil)
    }
    
    
}
