//
//  MovieDetailRouter.swift
//  Task
//
//  Created by Devansh Mohata on 28/09/24.
//

import UIKit

final class MovieDetailRouter {
    weak var view: UIViewController?
    
    static func createModule() -> MovieDetailViewController {
        let interactor = MovieDetailInteractor()
        
        let router = Self.init()
        
        let presenter = MovieDetailPresenter(interactor: interactor, router: router)
        
        let view = MovieDetailViewController(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}

// MARK: MDPresenterRouterProtocol
extension MovieDetailRouter: MDPresenterRouterProtocol { }
