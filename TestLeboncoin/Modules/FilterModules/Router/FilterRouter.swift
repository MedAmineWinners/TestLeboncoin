//
//  FilterRouter.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
import UIKit
class FilterRouter: FilterPresenterToRouterProtocol {
 
    static func createModule(categories: [Category]?) -> UIViewController {
        let view = FilterViewController()
        let presenter: FilterViewToPresenterProtocol & FilterInteractorToPresenterProtocol = FilterPresenter()
        let interactor: FilterPresenterToInteractorProtocol = FilterInteractor()
        let router: FilterPresenterToRouterProtocol = FilterRouter()

        view.presenter = presenter
        view.categories = categories ?? [Category]()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}
