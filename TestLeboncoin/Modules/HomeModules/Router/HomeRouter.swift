//
//  HomeRouter.swift
//  TestLeboncoin
//
//  Created by Stimlog on 06/10/2020.
//

import Foundation
import UIKit
class HomeRouter: PresenterToRouterProtocol {
    class func createModule() -> UIViewController {
        let view = HomeViewController()
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = HomePresenter()
        let interactor: PresenterToInteractorProtocol = HomeInteractor()
        let router: PresenterToRouterProtocol = HomeRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
    
        return view
    }
}
