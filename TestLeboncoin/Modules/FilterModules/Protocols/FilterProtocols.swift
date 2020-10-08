//
//  FilterProtocols.swift
//  TestLeboncoin
//
//  Created by Stimlog on 07/10/2020.
//

import Foundation
import UIKit
protocol FilterPresenterToViewProtocol: class{
    func showCategories(categories: [ItemCategory])
    func showError(error: String)
}

protocol FilterInteractorToPresenterProtocol: class {
    func categoriesFetchedWithSuccess(categories: [ItemCategory])
    func categoriesFetchedWithFailure(error: String)
}

protocol FilterPresenterToInteractorProtocol: class {
    var presenter: FilterInteractorToPresenterProtocol? { get set }
    func fetchCategories()
}

protocol FilterViewToPresenterProtocol: class {
    var view: FilterPresenterToViewProtocol? { get set }
    var interactor: FilterPresenterToInteractorProtocol? { get set }
    var router: FilterPresenterToRouterProtocol? { get set }
    func updateView()
}

protocol FilterPresenterToRouterProtocol {
    static func createModule(categories: [ItemCategory]?) -> UIViewController
}
